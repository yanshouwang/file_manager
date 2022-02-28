// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;

import 'core.dart';

const int DRIVE_UNKNOWN = 0;
const int DRIVE_NO_ROOT_DIR = 1;
const int DRIVE_REMOVABLE = 2;
const int DRIVE_FIXED = 3;
const int DRIVE_REMOTE = 4;
const int DRIVE_CDROM = 5;
const int DRIVE_RAMDISK = 6;

final _kernel32 = DynamicLibrary.open('kernel32.dll');

int GetLastError() {
  return _GetLastError();
}

late final _GetLastError = _kernel32
    .lookup<NativeFunction<DWORD Function()>>('GetLastError')
    .asFunction<int Function()>();

List<String> GetLogicalDriveStringsA() {
  final length0 = _GetLogicalDriveStringsA(0, nullptr);
  if (length0 == 0) {
    final statusCode = GetLastError();
    throw Win32Exception(statusCode);
  }
  final byteCount = sizeOf<CHAR>() * length0;
  final driveNamesPointer = ffi.calloc.allocate<CHAR>(byteCount);
  try {
    final length1 = _GetLogicalDriveStringsA(length0, driveNamesPointer);
    if (length1 == 0) {
      final statusCode = GetLastError();
      throw Win32Exception(statusCode);
    }
    return driveNamesPointer.toDartStringArray(length1);
  } finally {
    ffi.calloc.free(driveNamesPointer);
  }
}

late final _GetLogicalDriveStringsA = _kernel32
    .lookup<NativeFunction<DWORD Function(DWORD, LPSTR)>>(
        'GetLogicalDriveStringsA')
    .asFunction<int Function(int, LPSTR)>();

List<String> GetLogicalDriveStringsW() {
  final length0 = _GetLogicalDriveStringsW(0, nullptr);
  if (length0 == 0) {
    final statusCode = GetLastError();
    throw Win32Exception(statusCode);
  }
  final byteCount = sizeOf<WCHAR>() * length0;
  final driveNamesPointer = ffi.calloc.allocate<WCHAR>(byteCount);
  try {
    final length1 = _GetLogicalDriveStringsW(length0, driveNamesPointer);
    if (length1 == 0) {
      final statusCode = GetLastError();
      throw Win32Exception(statusCode);
    }
    return driveNamesPointer.toDartStringArray(length1);
  } finally {
    ffi.calloc.free(driveNamesPointer);
  }
}

late final _GetLogicalDriveStringsW = _kernel32
    .lookup<NativeFunction<DWORD Function(DWORD, LPWSTR)>>(
        'GetLogicalDriveStringsW')
    .asFunction<int Function(int, LPWSTR)>();

int GetDriveTypeW(String dirveName) {
  final driveNamePointer = dirveName.toNativeUint16Pointer();
  try {
    return _GetDriveTypeW(driveNamePointer);
  } finally {
    ffi.malloc.free(driveNamePointer);
  }
}

late final _GetDriveTypeW = _kernel32
    .lookup<NativeFunction<UINT Function(LPCWSTR)>>('GetDriveTypeW')
    .asFunction<int Function(LPCWSTR)>();
