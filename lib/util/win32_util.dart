import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart' as ffi;
import 'package:file_manager/models.dart';
import 'package:file_manager/win32.dart' as win32;

final _receiver = ReceivePort();
late SendPort _sender;

Stream<_Message> get _messages => _receiver.cast<_Message>();

Stream<DriveState> get driveStateChanged => _messages
    .where((message) => message.uMsg == win32.WM_DEVICECHANGE)
    .map((message) => message.driveState);

void runMessagesIsolate() {
  Isolate.spawn(_entryPoint, _receiver.sendPort);
}

void _entryPoint(SendPort sender) {
  _sender = sender;
  final hInstance = win32.GetModuleHandleW(nullptr);

  const style = win32.CS_HREDRAW | win32.CS_VREDRAW;
  final lpfnWndProc = Pointer.fromFunction<
      win32.LRESULT Function(
          win32.HWND, win32.UINT, win32.WPARAM, win32.LPARAM)>(_wndProc, 0);
  final lpszClassName = 'messages class'.toNativeUint16Pointer();
  final lpWndClass = ffi.calloc<win32.WNDCLASSW>()
    ..ref.hInstance = hInstance
    ..ref.style = style
    ..ref.lpfnWndProc = lpfnWndProc
    ..ref.lpszClassName = lpszClassName;
  final windowNamePointer = 'messages window'.toNativeUint16Pointer();
  try {
    final registered = win32.RegisterClassW(lpWndClass);
    if (registered == 0) {
      final statusCode = win32.GetLastError();
      throw win32.Win32Exception(statusCode);
    }

    final hWndParent = win32.HWND.fromAddress(win32.HWND_MESSAGE);
    final hWnd = win32.CreateWindowW(
      lpszClassName,
      windowNamePointer,
      win32.WS_OVERLAPPEDWINDOW,
      win32.CW_USEDEFAULT,
      win32.CW_USEDEFAULT,
      win32.CW_USEDEFAULT,
      win32.CW_USEDEFAULT,
      hWndParent,
      nullptr,
      hInstance,
      nullptr,
    );
    if (hWnd == nullptr) {
      final statusCode = win32.GetLastError();
      throw win32.Win32Exception(statusCode);
    }

    // const nCmdShow = win32.SW_SHOWDEFAULT;
    // win32.ShowWindow(hWnd, nCmdShow);

    final updated = win32.UpdateWindow(hWnd);
    if (updated == 0) {
      final statusCode = win32.GetLastError();
      throw win32.Win32Exception(statusCode);
    }

    final msg = ffi.calloc<win32.MSG>();
    while (win32.GetMessageW(msg, hWnd, 0, 0) > 0) {
      win32.TranslateMessage(msg);
      win32.DispatchMessageW(msg);
    }
  } finally {
    ffi.malloc.free(windowNamePointer);
    ffi.malloc.free(lpszClassName);
    ffi.calloc.free(lpWndClass);
  }
}

int _wndProc(win32.HWND hWnd, int uMsg, int wParam, int lParam) {
  if (uMsg == win32.WM_CREATE) {
    final notificationFilter =
        ffi.calloc<win32.DEV_BROADCAST_DEVICEINTERFACE_W>()
          ..ref.dbcc_size = sizeOf<win32.DEV_BROADCAST_DEVICEINTERFACE_W>()
          ..ref.dbcc_devicetype = win32.DBT_DEVTYP_DEVICEINTERFACE
          ..ref.dbcc_classguid.setValue(
            0x53f5630d,
            0xb6bf,
            0x11d0,
            [0x94, 0xf2, 0x00, 0xa0, 0xc9, 0x1e, 0xfb, 0x8b],
          );
    const flags = win32.DEVICE_NOTIFY_WINDOW_HANDLE;
    try {
      final deviceNotifyPointer = win32.RegisterDeviceNotificationW(
        hWnd,
        notificationFilter.cast(),
        flags,
      );
      if (deviceNotifyPointer == nullptr) {
        final statusCode = win32.GetLastError();
        throw win32.Win32Exception(statusCode);
      }
    } finally {
      ffi.calloc.free(notificationFilter);
    }
  }
  print('WndProc: $uMsg $wParam $lParam');
  final message = _Message(uMsg, wParam, lParam);
  _sender.send(message);
  return win32.DefWindowProcW(hWnd, uMsg, wParam, lParam);
}

class _Message {
  final int uMsg;
  final int wParam;
  final int lParam;

  const _Message(this.uMsg, this.wParam, this.lParam);
}

extension on _Message {
  DriveState get driveState {
    switch (wParam) {
      case win32.DBT_DEVICEARRIVAL:
        return DriveState.added;
      case win32.DBT_DEVICEREMOVECOMPLETE:
        return DriveState.removed;
      default:
        throw UnimplementedError();
    }
  }
}

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
