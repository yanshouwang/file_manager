// ignore_for_file: constant_identifier_names, non_constant_identifier_names, camel_case_types

import 'dart:ffi' as ffi;

import 'core.dart';

final _kernel32 = ffi.DynamicLibrary.open('kernel32.dll');

const DRIVE_UNKNOWN = 0;
const DRIVE_NO_ROOT_DIR = 1;
const DRIVE_REMOVABLE = 2;
const DRIVE_FIXED = 3;
const DRIVE_REMOTE = 4;
const DRIVE_CDROM = 5;
const DRIVE_RAMDISK = 6;

typedef STARTUPINFOW = _STARTUPINFOW;
typedef LPSTARTUPINFOW = ffi.Pointer<STARTUPINFOW>;
typedef PROCESS_INFORMATION = _PROCESS_INFORMATION;
typedef LPPROCESS_INFORMATION = ffi.Pointer<PROCESS_INFORMATION>;

class _STARTUPINFOW extends ffi.Struct {
  @DWORD()
  external int cb;
  external LPWSTR lpReserved;
  external LPWSTR lpDesktop;
  external LPWSTR lpTitle;
  @DWORD()
  external int dwX;
  @DWORD()
  external int dwY;
  @DWORD()
  external int dwXSize;
  @DWORD()
  external int dwYSize;
  @DWORD()
  external int dwXCountChars;
  @DWORD()
  external int dwYCountChars;
  @DWORD()
  external int dwFillAttribute;
  @DWORD()
  external int dwFlags;
  @WORD()
  external int wShowWindow;
  @WORD()
  external int cbReserved2;
  external LPBYTE lpReserved2;
  external HANDLE hStdInput;
  external HANDLE hStdOutput;
  external HANDLE hStdError;
}

class _PROCESS_INFORMATION extends ffi.Struct {
  external HANDLE hProcess;
  external HANDLE hThread;
  @DWORD()
  external int dwProcessId;
  @DWORD()
  external int dwThreadId;
}

int GetLastError() {
  return _GetLastError();
}

late final _GetLastError = _kernel32
    .lookup<ffi.NativeFunction<DWORD Function()>>('GetLastError')
    .asFunction<int Function()>();

int GetLogicalDriveStringsA(int nBufferLength, LPSTR lpBuffer) {
  return _GetLogicalDriveStringsA(nBufferLength, lpBuffer);
}

late final _GetLogicalDriveStringsA = _kernel32
    .lookup<ffi.NativeFunction<DWORD Function(DWORD, LPSTR)>>(
        'GetLogicalDriveStringsA')
    .asFunction<int Function(int, LPSTR)>();

int GetLogicalDriveStringsW(int nBufferLength, LPWSTR lpBuffer) {
  return _GetLogicalDriveStringsW(nBufferLength, lpBuffer);
}

late final _GetLogicalDriveStringsW = _kernel32
    .lookup<ffi.NativeFunction<DWORD Function(DWORD, LPWSTR)>>(
        'GetLogicalDriveStringsW')
    .asFunction<int Function(int, LPWSTR)>();

int GetDriveTypeW(LPCWSTR lpRootPathName) {
  return _GetDriveTypeW(lpRootPathName);
}

late final _GetDriveTypeW = _kernel32
    .lookup<ffi.NativeFunction<UINT Function(LPCWSTR)>>('GetDriveTypeW')
    .asFunction<int Function(LPCWSTR)>();

HMODULE GetModuleHandleW(LPCWSTR lpModuleName) {
  return _GetModuleHandleW(lpModuleName);
}

late final _GetModuleHandleW = _kernel32
    .lookup<ffi.NativeFunction<HMODULE Function(LPCWSTR)>>('GetModuleHandleW')
    .asFunction<HMODULE Function(LPCWSTR)>();

int CreateProcessW(
  LPCWSTR lpApplicationName,
  LPWSTR lpCommandLine,
  LPSECURITY_ATTRIBUTES lpProcessAttributes,
  LPSECURITY_ATTRIBUTES lpThreadAttributes,
  int bInheritHandles,
  int dwCreationFlags,
  LPVOID lpEnvironment,
  LPCWSTR lpCurrentDirectory,
  LPSTARTUPINFOW lpStartupInfo,
  LPPROCESS_INFORMATION lpProcessInformation,
) {
  return _CreateProcessW(
    lpApplicationName,
    lpCommandLine,
    lpProcessAttributes,
    lpThreadAttributes,
    bInheritHandles,
    dwCreationFlags,
    lpEnvironment,
    lpCurrentDirectory,
    lpStartupInfo,
    lpProcessInformation,
  );
}

late final _CreateProcessW = _kernel32
    .lookup<
        ffi.NativeFunction<
            BOOL Function(
                LPCWSTR,
                LPWSTR,
                LPSECURITY_ATTRIBUTES,
                LPSECURITY_ATTRIBUTES,
                BOOL,
                DWORD,
                LPVOID,
                LPCWSTR,
                LPSTARTUPINFOW,
                LPPROCESS_INFORMATION)>>('CreateProcessW')
    .asFunction<
        int Function(
            LPCWSTR,
            LPWSTR,
            LPSECURITY_ATTRIBUTES,
            LPSECURITY_ATTRIBUTES,
            int,
            int,
            LPVOID,
            LPCWSTR,
            LPSTARTUPINFOW,
            LPPROCESS_INFORMATION)>();

int WaitForSingleObject(HANDLE hHandle, int dwMilliseconds) {
  return _WaitForSingleObject(hHandle, dwMilliseconds);
}

late final _WaitForSingleObject = _kernel32
    .lookup<ffi.NativeFunction<DWORD Function(HANDLE, DWORD)>>(
        'WaitForSingleObject')
    .asFunction<int Function(HANDLE, int)>();

int CloseHandle(HANDLE hObject) {
  return _CloseHandle(hObject);
}

late final _CloseHandle = _kernel32
    .lookup<ffi.NativeFunction<BOOL Function(HANDLE)>>('CloseHandle')
    .asFunction<int Function(HANDLE)>();
