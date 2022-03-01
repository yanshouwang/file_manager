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

const CS_VREDRAW = 1;
const CS_HREDRAW = 2;
const CS_DBLCLKS = 8;
const CS_OWNDC = 32;
const CS_CLASSDC = 64;
const CS_PARENTDC = 128;
const CS_NOCLOSE = 512;
const CS_SAVEBITS = 2048;
const CS_BYTEALIGNCLIENT = 4096;
const CS_BYTEALIGNWINDOW = 8192;
const CS_GLOBALCLASS = 16384;
const CS_IME = 65536;
const CS_DROPSHADOW = 131072;

const WS_OVERLAPPED = 0;
const WS_POPUP = 2147483648;
const WS_CHILD = 1073741824;
const WS_MINIMIZE = 536870912;
const WS_VISIBLE = 268435456;
const WS_DISABLED = 134217728;
const WS_CLIPSIBLINGS = 67108864;
const WS_CLIPCHILDREN = 33554432;
const WS_MAXIMIZE = 16777216;
const WS_CAPTION = 12582912;
const WS_BORDER = 8388608;
const WS_DLGFRAME = 4194304;
const WS_VSCROLL = 2097152;
const WS_HSCROLL = 1048576;
const WS_SYSMENU = 524288;
const WS_THICKFRAME = 262144;
const WS_GROUP = 131072;
const WS_TABSTOP = 65536;
const WS_MINIMIZEBOX = 131072;
const WS_MAXIMIZEBOX = 65536;
const WS_TILED = 0;
const WS_ICONIC = 536870912;
const WS_SIZEBOX = 262144;
const WS_TILEDWINDOW = 13565952;
const WS_OVERLAPPEDWINDOW = 13565952;
const WS_POPUPWINDOW = 2156396544;
const WS_CHILDWINDOW = 1073741824;

const WS_EX_DLGMODALFRAME = 1;
const WS_EX_NOPARENTNOTIFY = 4;
const WS_EX_TOPMOST = 8;
const WS_EX_ACCEPTFILES = 16;
const WS_EX_TRANSPARENT = 32;
const WS_EX_MDICHILD = 64;
const WS_EX_TOOLWINDOW = 128;
const WS_EX_WINDOWEDGE = 256;
const WS_EX_CLIENTEDGE = 512;
const WS_EX_CONTEXTHELP = 1024;
const WS_EX_RIGHT = 4096;
const WS_EX_LEFT = 0;
const WS_EX_RTLREADING = 8192;
const WS_EX_LTRREADING = 0;
const WS_EX_LEFTSCROLLBAR = 16384;
const WS_EX_RIGHTSCROLLBAR = 0;
const WS_EX_CONTROLPARENT = 65536;
const WS_EX_STATICEDGE = 131072;
const WS_EX_APPWINDOW = 262144;
const WS_EX_OVERLAPPEDWINDOW = 768;
const WS_EX_PALETTEWINDOW = 392;
const WS_EX_LAYERED = 524288;
const WS_EX_NOINHERITLAYOUT = 1048576;
const WS_EX_LAYOUTRTL = 4194304;
const WS_EX_COMPOSITED = 33554432;
const WS_EX_NOACTIVATE = 134217728;

const CW_USEDEFAULT = -2147483648;

const SW_HIDE = 0;
const SW_SHOWNORMAL = 1;
const SW_NORMAL = 1;
const SW_SHOWMINIMIZED = 2;
const SW_SHOWMAXIMIZED = 3;
const SW_MAXIMIZE = 3;
const SW_SHOWNOACTIVATE = 4;
const SW_SHOW = 5;
const SW_MINIMIZE = 6;
const SW_SHOWMINNOACTIVE = 7;
const SW_SHOWNA = 8;
const SW_RESTORE = 9;
const SW_SHOWDEFAULT = 10;
const SW_FORCEMINIMIZE = 11;
const SW_MAX = 11;

const IDI_APPLICATION = 32512;
const IDI_HAND = 32513;
const IDI_QUESTION = 32514;
const IDI_EXCLAMATION = 32515;
const IDI_ASTERISK = 32516;

const IDC_ARROW = 32512;
const IDC_IBEAM = 32513;
const IDC_WAIT = 32514;
const IDC_CROSS = 32515;
const IDC_UPARROW = 32516;
const IDC_SIZE = 32640;
const IDC_ICON = 32641;
const IDC_SIZENWSE = 32642;
const IDC_SIZENESW = 32643;
const IDC_SIZEWE = 32644;
const IDC_SIZENS = 32645;
const IDC_SIZEALL = 32646;
const IDC_NO = 32648;
const IDC_HAND = 32649;
const IDC_APPSTARTING = 32650;
const IDC_HELP = 32651;
const IDC_PIN = 32671;
const IDC_PERSON = 32672;

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

int RegisterClassW(Pointer<WNDCLASSW> lpWndClass) {
  return _RegisterClassW(lpWndClass);
}

late final _RegisterClassW = _user32
    .lookup<NativeFunction<ATOM Function(Pointer<WNDCLASSW>)>>('RegisterClassW')
    .asFunction<int Function(Pointer<WNDCLASSW>)>();

HWND CreateWindowW(
  LPCWSTR lpClassName,
  LPCWSTR lpWindowName,
  int dwStyle,
  int X,
  int Y,
  int nWidth,
  int nHeight,
  HWND hWndParent,
  HMENU hMenu,
  HINSTANCE hInstance,
  LPVOID lpParam,
) {
  return CreateWindowExW(
    0,
    lpClassName,
    lpWindowName,
    dwStyle,
    X,
    Y,
    nWidth,
    nHeight,
    hWndParent,
    hMenu,
    hInstance,
    lpParam,
  );
}

HWND CreateWindowExW(
  int dwExStyle,
  LPCWSTR lpClassName,
  LPCWSTR lpWindowName,
  int dwStyle,
  int X,
  int Y,
  int nWidth,
  int nHeight,
  HWND hWndParent,
  HMENU hMenu,
  HINSTANCE hInstance,
  LPVOID lpParam,
) {
  return _CreateWindowExW(
    dwExStyle,
    lpClassName,
    lpWindowName,
    dwStyle,
    X,
    Y,
    nWidth,
    nHeight,
    hWndParent,
    hMenu,
    hInstance,
    lpParam,
  );
}

late final _CreateWindowExW = _user32
    .lookup<
        NativeFunction<
            HWND Function(DWORD, LPCWSTR, LPCWSTR, DWORD, Int32, Int32, Int32,
                Int32, HWND, HMENU, HINSTANCE, LPVOID)>>('CreateWindowExW')
    .asFunction<
        HWND Function(int, LPCWSTR, LPCWSTR, int, int, int, int, int, HWND,
            HMENU, HINSTANCE, LPVOID)>();

int ShowWindow(HWND hWnd, int nCmdShow) {
  return _ShowWindow(hWnd, nCmdShow);
}

late final _ShowWindow = _user32
    .lookup<NativeFunction<BOOL Function(HWND, Int32)>>('ShowWindow')
    .asFunction<int Function(HWND, int)>();

int ShowWindowAsync(HWND hWnd, int nCmdShow) {
  return _ShowWindowAsync(hWnd, nCmdShow);
}

late final _ShowWindowAsync = _user32
    .lookup<NativeFunction<BOOL Function(HWND, Int32)>>('ShowWindowAsync')
    .asFunction<int Function(HWND, int)>();

int UpdateWindow(HWND hWnd) {
  return _UpdateWindow(hWnd);
}

late final _UpdateWindow = _user32
    .lookup<NativeFunction<BOOL Function(HWND)>>('UpdateWindow')
    .asFunction<int Function(HWND)>();

HICON LoadIconW(HINSTANCE hInstance, LPCWSTR lpIconName) {
  return _LoadIconW(hInstance, lpIconName);
}

late final _LoadIconW = _user32
    .lookup<NativeFunction<HICON Function(HINSTANCE, LPCWSTR)>>('LoadIconW')
    .asFunction<HICON Function(HINSTANCE, LPCWSTR)>();

HCURSOR LoadCursorW(HINSTANCE hInstance, LPCWSTR lpCursorName) {
  return _LoadCursorW(hInstance, lpCursorName);
}

late final _LoadCursorW = _user32
    .lookup<NativeFunction<HCURSOR Function(HINSTANCE, LPCWSTR)>>('LoadCursorW')
    .asFunction<HCURSOR Function(HINSTANCE, LPCWSTR)>();
