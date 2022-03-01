import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;
import 'package:file_manager/models.dart';
import 'package:file_manager/win32.dart' as win32;

List<Drive> getDrives() {
  return getDriveNamesW().map((name) {
    final typeNumber = getDriveTypeW(name);
    final type = DriveType.values[typeNumber];
    return Drive(name, type);
  }).toList();
}

List<String> getDriveNamesA() {
  final length0 = win32.GetLogicalDriveStringsA(0, nullptr);
  if (length0 == 0) {
    final statusCode = win32.GetLastError();
    throw win32.Win32Exception(statusCode);
  }
  final byteCount = sizeOf<win32.CHAR>() * length0;
  final driveNamesPointer = ffi.calloc.allocate<win32.CHAR>(byteCount);
  try {
    final length1 = win32.GetLogicalDriveStringsA(length0, driveNamesPointer);
    if (length1 == 0) {
      final statusCode = win32.GetLastError();
      throw win32.Win32Exception(statusCode);
    }
    return driveNamesPointer.toDartStringArray(length1);
  } finally {
    ffi.calloc.free(driveNamesPointer);
  }
}

List<String> getDriveNamesW() {
  final length0 = win32.GetLogicalDriveStringsW(0, nullptr);
  if (length0 == 0) {
    final statusCode = win32.GetLastError();
    throw win32.Win32Exception(statusCode);
  }
  final byteCount = sizeOf<win32.WCHAR>() * length0;
  final driveNamesPointer = ffi.calloc.allocate<win32.WCHAR>(byteCount);
  try {
    final length1 = win32.GetLogicalDriveStringsW(length0, driveNamesPointer);
    if (length1 == 0) {
      final statusCode = win32.GetLastError();
      throw win32.Win32Exception(statusCode);
    }
    return driveNamesPointer.toDartStringArray(length1);
  } finally {
    ffi.calloc.free(driveNamesPointer);
  }
}

int getDriveTypeW(String dirveName) {
  final driveNamePointer = dirveName.toNativeUint16Pointer();
  try {
    return win32.GetDriveTypeW(driveNamePointer);
  } finally {
    ffi.malloc.free(driveNamePointer);
  }
}

List<int> removeCRs(List<int> bytes) {
  final removedBytes = <int>[];
  for (var i = 0; i < bytes.length - 1; i++) {
    final firstByte = bytes[i];
    final secondByte = bytes[i + 1];
    if (firstByte == 0x0d && secondByte == 0x0a) {
      continue;
    }
    removedBytes.add(firstByte);
  }
  removedBytes.add(bytes.last);
  return removedBytes;
}

// TODO: doesn't work for now, wondering if we can use SetWindowsHookExW in flutter.
late final win32.HHOOK _hhk;

int _hookproc(int code, int wParam, int lParam) {
  final message = Pointer.fromAddress(lParam).cast<win32.CWPSTRUCT>().ref;
  _messagesController.add(message);
  final nCode = code;
  return win32.CallNextHookEx(_hhk, nCode, wParam, lParam);
}

late final _messagesController = StreamController<win32.CWPSTRUCT>.broadcast(
  onListen: () {
    const idHook = win32.WH_KEYBOARD_LL;
    final lpfn = Pointer.fromFunction<
        win32.LRESULT Function(Int32, win32.WPARAM, win32.LPARAM)>(
      _hookproc,
      0,
    );
    final hmod = win32.GetModuleHandleW(nullptr);
    const dwThreadId = 0;
    _hhk = win32.SetWindowsHookExW(idHook, lpfn, hmod, dwThreadId);
  },
  onCancel: () {
    final unhoooked = win32.UnhookWindowsHookEx(_hhk);
    if (unhoooked == 0) {
      final statusCode = win32.GetLastError();
      throw win32.Win32Exception(statusCode);
    }
  },
);

Stream<win32.CWPSTRUCT> get messages => _messagesController.stream;
