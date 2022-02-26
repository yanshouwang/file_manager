import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;

import 'errors.dart';
import 'types.dart';

const FACILITY_WIN32 = 7;

const int DRIVE_UNKNOWN = 0;
const int DRIVE_NO_ROOT_DIR = 1;
const int DRIVE_REMOVABLE = 2;
const int DRIVE_FIXED = 3;
const int DRIVE_REMOTE = 4;
const int DRIVE_CDROM = 5;
const int DRIVE_RAMDISK = 6;

final kernel32 = DynamicLibrary.open('kernel32.dll');

int GetLastError() {
  return _GetLastError();
}

late final _GetLastError = kernel32
    .lookup<NativeFunction<DWORD Function()>>('GetLastError')
    .asFunction<int Function()>();

int HRESULT_FROM_WIN32(int x) =>
    (x <= 0 ? x : (x & 0x0000FFFF | (FACILITY_WIN32 << 16) | 0x80000000))
        .toSigned(32);

List<String> GetLogicalDriveStringsW() {
  final nBufferLength0 = _GetLogicalDriveStringsW(0, nullptr);
  if (nBufferLength0 == 0) {
    return [];
  }
  final lpBuffer = ffi.calloc.allocate<ffi.Utf16>(nBufferLength0);
  try {
    final nBufferLength1 = _GetLogicalDriveStringsW(nBufferLength0, lpBuffer);
    if (nBufferLength1 == 0) {
      final x = GetLastError();
      final hr = HRESULT_FROM_WIN32(x);
      throw Win32Exception(hr);
    }
    return lpBuffer.toDartStringArray(nBufferLength1);
  } finally {
    ffi.calloc.free(lpBuffer);
  }
}

late final _GetLogicalDriveStringsW = kernel32
    .lookup<NativeFunction<DWORD Function(DWORD, LPWSTR)>>(
        'GetLogicalDriveStringsW')
    .asFunction<int Function(int, LPWSTR)>();

int GetDriveTypeW(String rootPathName) {
  final lpRootPathName = rootPathName.toNativeUtf16();
  try {
    return _GetDriveTypeW(lpRootPathName);
  } finally {
    ffi.calloc.free(lpRootPathName);
  }
}

late final _GetDriveTypeW = kernel32
    .lookup<NativeFunction<UINT Function(LPCWSTR)>>('GetDriveTypeW')
    .asFunction<int Function(LPCWSTR)>();
