// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:ffi';

import 'core.dart';

final _kernel32 = DynamicLibrary.open('kernel32.dll');

const DRIVE_UNKNOWN = 0;
const DRIVE_NO_ROOT_DIR = 1;
const DRIVE_REMOVABLE = 2;
const DRIVE_FIXED = 3;
const DRIVE_REMOTE = 4;
const DRIVE_CDROM = 5;
const DRIVE_RAMDISK = 6;

int GetLastError() {
  return _GetLastError();
}

late final _GetLastError = _kernel32
    .lookup<NativeFunction<DWORD Function()>>('GetLastError')
    .asFunction<int Function()>();

int GetLogicalDriveStringsA(
  int nBufferLength,
  LPSTR lpBuffer,
) {
  return _GetLogicalDriveStringsA(
    nBufferLength,
    lpBuffer,
  );
}

late final _GetLogicalDriveStringsA = _kernel32
    .lookup<NativeFunction<DWORD Function(DWORD, LPSTR)>>(
        'GetLogicalDriveStringsA')
    .asFunction<int Function(int, LPSTR)>();

int GetLogicalDriveStringsW(
  int nBufferLength,
  LPWSTR lpBuffer,
) {
  return _GetLogicalDriveStringsW(
    nBufferLength,
    lpBuffer,
  );
}

late final _GetLogicalDriveStringsW = _kernel32
    .lookup<NativeFunction<DWORD Function(DWORD, LPWSTR)>>(
        'GetLogicalDriveStringsW')
    .asFunction<int Function(int, LPWSTR)>();

int GetDriveTypeW(
  LPCWSTR lpRootPathName,
) {
  return _GetDriveTypeW(
    lpRootPathName,
  );
}

late final _GetDriveTypeW = _kernel32
    .lookup<NativeFunction<UINT Function(LPCWSTR)>>('GetDriveTypeW')
    .asFunction<int Function(LPCWSTR)>();

HMODULE GetModuleHandleW(
  LPCWSTR lpModuleName,
) {
  return _GetModuleHandleW(
    lpModuleName,
  );
}

late final _GetModuleHandleW = _kernel32
    .lookup<NativeFunction<HMODULE Function(LPCWSTR)>>('GetModuleHandleW')
    .asFunction<HMODULE Function(LPCWSTR)>();
