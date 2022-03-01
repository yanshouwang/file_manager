// ignore_for_file: constant_identifier_names, non_constant_identifier_names, camel_case_types

import 'dart:ffi';

import 'core.dart';

final _user32 = DynamicLibrary.open('user32.dll');

const WH_MIN = -1;
const WH_MSGFILTER = -1;
const WH_JOURNALRECORD = 0;
const WH_JOURNALPLAYBACK = 1;
const WH_KEYBOARD = 2;
const WH_GETMESSAGE = 3;
const WH_CALLWNDPROC = 4;
const WH_CBT = 5;
const WH_SYSMSGFILTER = 6;
const WH_MOUSE = 7;
const WH_DEBUG = 9;
const WH_SHELL = 10;
const WH_FOREGROUNDIDLE = 11;
const WH_CALLWNDPROCRET = 12;
const WH_KEYBOARD_LL = 13;
const WH_MOUSE_LL = 14;
const WH_MAX = 14;
const WH_MINHOOK = -1;
const WH_MAXHOOK = 14;

typedef HOOKPROC
    = Pointer<NativeFunction<LRESULT Function(Int32, WPARAM, LPARAM)>>;
typedef CWPSTRUCT = tagCWPSTRUCT;
typedef WNDCLASSW = tagWNDCLASSW;
typedef WNDPROC
    = Pointer<NativeFunction<LRESULT Function(HWND, UINT, WPARAM, LPARAM)>>;

class tagCWPSTRUCT extends Struct {
  @LPARAM()
  external int lParam;
  @WPARAM()
  external int wParam;
  @UINT()
  external int message;
  external HWND hwnd;
}

class tagWNDCLASSW extends Struct {
  @UINT()
  external int style;
  external WNDPROC lpfnWndProc;
  @Int32()
  external int cbClsExtra;
  @Int32()
  external int cbWndExtra;
  external HINSTANCE hInstance;
  external HICON hIcon;
  external HCURSOR hCursor;
  external HBRUSH hbrBackground;
  external LPCWSTR lpszMenuName;
  external LPCWSTR lpszClassName;
}

HHOOK SetWindowsHookExW(
  int idHook,
  HOOKPROC lpfn,
  HINSTANCE hmod,
  int dwThreadId,
) {
  return _SetWindowsHookExW(idHook, lpfn, hmod, dwThreadId);
}

late final _SetWindowsHookExW = _user32
    .lookup<NativeFunction<HHOOK Function(Int32, HOOKPROC, HINSTANCE, DWORD)>>(
        'SetWindowsHookExW')
    .asFunction<HHOOK Function(int, HOOKPROC, HINSTANCE, int)>();

int CallNextHookEx(HHOOK hhk, int nCode, int wParam, int lParam) {
  return _CallNextHookEx(hhk, nCode, wParam, lParam);
}

late final _CallNextHookEx = _user32
    .lookup<NativeFunction<LRESULT Function(HHOOK, Int32, WPARAM, LPARAM)>>(
        'CallNextHookEx')
    .asFunction<int Function(HHOOK, int, int, int)>();

int UnhookWindowsHookEx(HHOOK hhk) {
  return _UnhookWindowsHookEx(hhk);
}

late final _UnhookWindowsHookEx = _user32
    .lookup<NativeFunction<BOOL Function(HHOOK)>>('UnhookWindowsHookEx')
    .asFunction<int Function(HHOOK)>();

int RegisterClassW(
  Pointer<WNDCLASSW> lpWndClass,
) {
  return _RegisterClassW(
    lpWndClass,
  );
}

late final _RegisterClassW = _user32
    .lookup<NativeFunction<ATOM Function(Pointer<WNDCLASSW>)>>('RegisterClassW')
    .asFunction<int Function(Pointer<WNDCLASSW>)>();
