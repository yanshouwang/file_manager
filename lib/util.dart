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

int _hookProc(int code, int wParam, int lParam) {
  final message = WindowsMessage(code, wParam, lParam);
  _messagesController.add(message);
  final nCode = code;
  return win32.CallNextHookEx(_hhk, nCode, wParam, lParam);
}

int _wndProc(win32.HWND hWnd, int uMsg, int wParam, int lParam) {
  print('_wndProc: $hWnd $uMsg $wParam $lParam}');
  return 0;
}

class WindowsMessage {
  final int code;
  final int wParam;
  final int lParam;

  const WindowsMessage(this.code, this.wParam, this.lParam);
}

late final _messagesController = StreamController<WindowsMessage>.broadcast(
  onListen: () {
    final hInstance = win32.GetModuleHandleW(nullptr);
    const style = win32.CS_HREDRAW | win32.CS_VREDRAW;
    final lpfnWndProc = Pointer.fromFunction<
        win32.LRESULT Function(
            win32.HWND, win32.UINT, win32.WPARAM, win32.LPARAM)>(
      _wndProc,
      0,
    );
    final lpszClassName = 'hook class'.toNativeUint16Pointer();
    final lpIconName = win32.LPCWSTR.fromAddress(win32.IDI_APPLICATION);
    final lpCursorName = win32.LPCWSTR.fromAddress(win32.IDC_ARROW);
    final lpWndClass = ffi.calloc<win32.WNDCLASSW>()
      ..ref.hInstance = hInstance
      ..ref.style = style
      ..ref.lpfnWndProc = lpfnWndProc
      ..ref.lpszClassName = lpszClassName
      ..ref.hIcon = win32.LoadIconW(nullptr, lpIconName)
      ..ref.hCursor = win32.LoadCursorW(nullptr, lpCursorName)
      ..ref.hbrBackground = win32.GetStockObject(win32.WHITE_BRUSH);
    final lpWindowName = 'hook window'.toNativeUint16Pointer();
    try {
      final atom = win32.RegisterClassW(lpWndClass);
      if (atom == 0) {
        final statusCode = win32.GetLastError();
        throw win32.Win32Exception(statusCode);
      }
      final hWnd = win32.CreateWindowW(
        lpszClassName,
        lpWindowName,
        win32.WS_OVERLAPPEDWINDOW,
        win32.CW_USEDEFAULT,
        win32.CW_USEDEFAULT,
        win32.CW_USEDEFAULT,
        win32.CW_USEDEFAULT,
        nullptr,
        nullptr,
        hInstance,
        nullptr,
      );
      print('hWnd: $hWnd');
      const nCmdShow = win32.SW_SHOWDEFAULT;
      win32.ShowWindow(hWnd, nCmdShow);
      win32.UpdateWindow(hWnd);
      const idHook = win32.WH_KEYBOARD_LL;
      final lpfn = Pointer.fromFunction<
          win32.LRESULT Function(Int32, win32.WPARAM, win32.LPARAM)>(
        _hookProc,
        0,
      );
      const dwThreadId = 0;
      _hhk = win32.SetWindowsHookExW(idHook, lpfn, nullptr, dwThreadId);
    } finally {
      ffi.malloc.free(lpWindowName);
      ffi.malloc.free(lpszClassName);
      ffi.calloc.free(lpWndClass);
    }
  },
  onCancel: () {
    final unhoooked = win32.UnhookWindowsHookEx(_hhk);
    if (unhoooked == 0) {
      final statusCode = win32.GetLastError();
      throw win32.Win32Exception(statusCode);
    }
  },
);

Stream<WindowsMessage> get messages => _messagesController.stream;
