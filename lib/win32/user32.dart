// ignore_for_file: constant_identifier_names, non_constant_identifier_names, camel_case_types

import 'dart:ffi' as ffi;

import 'core.dart';

final _user32 = ffi.DynamicLibrary.open('user32.dll');

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

const HWND_MESSAGE = -3;

const DEVICE_NOTIFY_WINDOW_HANDLE = 0;
const DEVICE_NOTIFY_SERVICE_HANDLE = 1;
const DEVICE_NOTIFY_ALL_INTERFACE_CLASSES = 4;

const WM_NULL = 0;
const WM_CREATE = 1;
const WM_DESTROY = 2;
const WM_MOVE = 3;
const WM_SIZE = 5;
const WM_ACTIVATE = 6;
const WA_INACTIVE = 0;
const WA_ACTIVE = 1;
const WA_CLICKACTIVE = 2;
const WM_SETFOCUS = 7;
const WM_KILLFOCUS = 8;
const WM_ENABLE = 10;
const WM_SETREDRAW = 11;
const WM_SETTEXT = 12;
const WM_GETTEXT = 13;
const WM_GETTEXTLENGTH = 14;
const WM_PAINT = 15;
const WM_CLOSE = 16;
const WM_QUERYENDSESSION = 17;
const WM_QUERYOPEN = 19;
const WM_ENDSESSION = 22;
const WM_QUIT = 18;
const WM_ERASEBKGND = 20;
const WM_SYSCOLORCHANGE = 21;
const WM_SHOWWINDOW = 24;
const WM_WININICHANGE = 26;
const WM_SETTINGCHANGE = 26;
const WM_DEVMODECHANGE = 27;
const WM_ACTIVATEAPP = 28;
const WM_FONTCHANGE = 29;
const WM_TIMECHANGE = 30;
const WM_CANCELMODE = 31;
const WM_SETCURSOR = 32;
const WM_MOUSEACTIVATE = 33;
const WM_CHILDACTIVATE = 34;
const WM_QUEUESYNC = 35;
const WM_GETMINMAXINFO = 36;
const WM_PAINTICON = 38;
const WM_ICONERASEBKGND = 39;
const WM_NEXTDLGCTL = 40;
const WM_SPOOLERSTATUS = 42;
const WM_DRAWITEM = 43;
const WM_MEASUREITEM = 44;
const WM_DELETEITEM = 45;
const WM_VKEYTOITEM = 46;
const WM_CHARTOITEM = 47;
const WM_SETFONT = 48;
const WM_GETFONT = 49;
const WM_SETHOTKEY = 50;
const WM_GETHOTKEY = 51;
const WM_QUERYDRAGICON = 55;
const WM_COMPAREITEM = 57;
const WM_GETOBJECT = 61;
const WM_COMPACTING = 65;
const WM_COMMNOTIFY = 68;
const WM_WINDOWPOSCHANGING = 70;
const WM_WINDOWPOSCHANGED = 71;
const WM_POWER = 72;
const WM_DEVICECHANGE = 537;
const WM_MDICREATE = 544;
const WM_MDIDESTROY = 545;
const WM_MDIACTIVATE = 546;
const WM_MDIRESTORE = 547;
const WM_MDINEXT = 548;
const WM_MDIMAXIMIZE = 549;
const WM_MDITILE = 550;
const WM_MDICASCADE = 551;
const WM_MDIICONARRANGE = 552;
const WM_MDIGETACTIVE = 553;
const WM_MDISETMENU = 560;
const WM_ENTERSIZEMOVE = 561;
const WM_EXITSIZEMOVE = 562;
const WM_DROPFILES = 563;
const WM_MDIREFRESHMENU = 564;
const WM_POINTERDEVICECHANGE = 568;
const WM_POINTERDEVICEINRANGE = 569;
const WM_POINTERDEVICEOUTOFRANGE = 570;
const WM_TOUCH = 576;
const WM_NCPOINTERUPDATE = 577;
const WM_NCPOINTERDOWN = 578;
const WM_NCPOINTERUP = 579;
const WM_POINTERUPDATE = 581;
const WM_POINTERDOWN = 582;
const WM_POINTERUP = 583;
const WM_POINTERENTER = 585;
const WM_POINTERLEAVE = 586;
const WM_POINTERACTIVATE = 587;
const WM_POINTERCAPTURECHANGED = 588;
const WM_TOUCHHITTESTING = 589;
const WM_POINTERWHEEL = 590;
const WM_POINTERHWHEEL = 591;
const DM_POINTERHITTEST = 592;
const WM_POINTERROUTEDTO = 593;
const WM_POINTERROUTEDAWAY = 594;
const WM_POINTERROUTEDRELEASED = 595;
const WM_IME_SETCONTEXT = 641;
const WM_IME_NOTIFY = 642;
const WM_IME_CONTROL = 643;
const WM_IME_COMPOSITIONFULL = 644;
const WM_IME_SELECT = 645;
const WM_IME_CHAR = 646;
const WM_IME_REQUEST = 648;
const WM_IME_KEYDOWN = 656;
const WM_IME_KEYUP = 657;
const WM_MOUSEHOVER = 673;
const WM_MOUSELEAVE = 675;
const WM_NCMOUSEHOVER = 672;
const WM_NCMOUSELEAVE = 674;
const WM_WTSSESSION_CHANGE = 689;
const WM_TABLET_FIRST = 704;
const WM_TABLET_LAST = 735;
const WM_DPICHANGED = 736;
const WM_DPICHANGED_BEFOREPARENT = 738;
const WM_DPICHANGED_AFTERPARENT = 739;
const WM_GETDPISCALEDSIZE = 740;
const WM_CUT = 768;
const WM_COPY = 769;
const WM_PASTE = 770;
const WM_CLEAR = 771;
const WM_UNDO = 772;
const WM_RENDERFORMAT = 773;
const WM_RENDERALLFORMATS = 774;
const WM_DESTROYCLIPBOARD = 775;
const WM_DRAWCLIPBOARD = 776;
const WM_PAINTCLIPBOARD = 777;
const WM_VSCROLLCLIPBOARD = 778;
const WM_SIZECLIPBOARD = 779;
const WM_ASKCBFORMATNAME = 780;
const WM_CHANGECBCHAIN = 781;
const WM_HSCROLLCLIPBOARD = 782;
const WM_QUERYNEWPALETTE = 783;
const WM_PALETTEISCHANGING = 784;
const WM_PALETTECHANGED = 785;
const WM_HOTKEY = 786;
const WM_PRINT = 791;
const WM_PRINTCLIENT = 792;
const WM_APPCOMMAND = 793;
const WM_THEMECHANGED = 794;
const WM_CLIPBOARDUPDATE = 797;
const WM_DWMCOMPOSITIONCHANGED = 798;
const WM_DWMNCRENDERINGCHANGED = 799;
const WM_DWMCOLORIZATIONCOLORCHANGED = 800;
const WM_DWMWINDOWMAXIMIZEDCHANGE = 801;
const WM_DWMSENDICONICTHUMBNAIL = 803;
const WM_DWMSENDICONICLIVEPREVIEWBITMAP = 806;
const WM_GETTITLEBARINFOEX = 831;
const WM_HANDHELDFIRST = 856;
const WM_HANDHELDLAST = 863;
const WM_AFXFIRST = 864;
const WM_AFXLAST = 895;
const WM_PENWINFIRST = 896;
const WM_PENWINLAST = 911;
const WM_APP = 32768;
const WM_USER = 1024;

const WMSZ_LEFT = 1;
const WMSZ_RIGHT = 2;
const WMSZ_TOP = 3;
const WMSZ_TOPLEFT = 4;
const WMSZ_TOPRIGHT = 5;
const WMSZ_BOTTOM = 6;
const WMSZ_BOTTOMLEFT = 7;
const WMSZ_BOTTOMRIGHT = 8;

const int DBT_APPYBEGIN = 0;

const DBT_APPYEND = 1;
const DBT_DEVNODES_CHANGED = 7;
const DBT_QUERYCHANGECONFIG = 23;
const DBT_CONFIGCHANGED = 24;
const DBT_CONFIGCHANGECANCELED = 25;
const DBT_MONITORCHANGE = 27;
const DBT_SHELLLOGGEDON = 32;
const DBT_CONFIGMGAPI32 = 34;
const DBT_VXDINITCOMPLETE = 35;
const DBT_VOLLOCKQUERYLOCK = 32833;
const DBT_VOLLOCKLOCKTAKEN = 32834;
const DBT_VOLLOCKLOCKFAILED = 32835;
const DBT_VOLLOCKQUERYUNLOCK = 32836;
const DBT_VOLLOCKLOCKRELEASED = 32837;
const DBT_VOLLOCKUNLOCKFAILED = 32838;
const DBT_NO_DISK_SPACE = 71;
const DBT_LOW_DISK_SPACE = 72;
const DBT_CONFIGMGPRIVATE = 32767;
const DBT_DEVICEARRIVAL = 32768;
const DBT_DEVICEQUERYREMOVE = 32769;
const DBT_DEVICEQUERYREMOVEFAILED = 32770;
const DBT_DEVICEREMOVEPENDING = 32771;
const DBT_DEVICEREMOVECOMPLETE = 32772;
const DBT_DEVICETYPESPECIFIC = 32773;
const DBT_DEVTYP_OEM = 0;
const DBT_DEVTYP_DEVNODE = 1;
const DBT_DEVTYP_VOLUME = 2;
const DBT_DEVTYP_PORT = 3;
const DBT_DEVTYP_NET = 4;

typedef HOOKPROC = ffi
    .Pointer<ffi.NativeFunction<LRESULT Function(ffi.Int32, WPARAM, LPARAM)>>;
typedef CWPSTRUCT = tagCWPSTRUCT;
typedef WNDCLASSW = tagWNDCLASSW;
typedef WNDPROC = ffi
    .Pointer<ffi.NativeFunction<LRESULT Function(HWND, UINT, WPARAM, LPARAM)>>;
typedef LPMSG = ffi.Pointer<MSG>;
typedef MSG = tagMSG;
typedef HDEVNOTIFY = PVOID;

class tagCWPSTRUCT extends ffi.Struct {
  @LPARAM()
  external int lParam;
  @WPARAM()
  external int wParam;
  @UINT()
  external int message;
  external HWND hwnd;
}

class tagWNDCLASSW extends ffi.Struct {
  @UINT()
  external int style;
  external WNDPROC lpfnWndProc;
  @ffi.Int32()
  external int cbClsExtra;
  @ffi.Int32()
  external int cbWndExtra;
  external HINSTANCE hInstance;
  external HICON hIcon;
  external HCURSOR hCursor;
  external HBRUSH hbrBackground;
  external LPCWSTR lpszMenuName;
  external LPCWSTR lpszClassName;
}

class tagMSG extends ffi.Struct {
  external HWND hwnd;
  @UINT()
  external int message;
  @WPARAM()
  external int wParam;
  @LPARAM()
  external int lParam;
  @DWORD()
  external int time;
  external POINT pt;
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
    .lookup<
        ffi.NativeFunction<
            HHOOK Function(
                ffi.Int32, HOOKPROC, HINSTANCE, DWORD)>>('SetWindowsHookExW')
    .asFunction<HHOOK Function(int, HOOKPROC, HINSTANCE, int)>();

int CallNextHookEx(HHOOK hhk, int nCode, int wParam, int lParam) {
  return _CallNextHookEx(hhk, nCode, wParam, lParam);
}

late final _CallNextHookEx = _user32
    .lookup<
        ffi.NativeFunction<
            LRESULT Function(
                HHOOK, ffi.Int32, WPARAM, LPARAM)>>('CallNextHookEx')
    .asFunction<int Function(HHOOK, int, int, int)>();

int UnhookWindowsHookEx(HHOOK hhk) {
  return _UnhookWindowsHookEx(hhk);
}

late final _UnhookWindowsHookEx = _user32
    .lookup<ffi.NativeFunction<BOOL Function(HHOOK)>>('UnhookWindowsHookEx')
    .asFunction<int Function(HHOOK)>();

int RegisterClassW(ffi.Pointer<WNDCLASSW> lpWndClass) {
  return _RegisterClassW(lpWndClass);
}

late final _RegisterClassW = _user32
    .lookup<ffi.NativeFunction<ATOM Function(ffi.Pointer<WNDCLASSW>)>>(
        'RegisterClassW')
    .asFunction<int Function(ffi.Pointer<WNDCLASSW>)>();

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
        ffi.NativeFunction<
            HWND Function(
                DWORD,
                LPCWSTR,
                LPCWSTR,
                DWORD,
                ffi.Int32,
                ffi.Int32,
                ffi.Int32,
                ffi.Int32,
                HWND,
                HMENU,
                HINSTANCE,
                LPVOID)>>('CreateWindowExW')
    .asFunction<
        HWND Function(int, LPCWSTR, LPCWSTR, int, int, int, int, int, HWND,
            HMENU, HINSTANCE, LPVOID)>();

int ShowWindow(HWND hWnd, int nCmdShow) {
  return _ShowWindow(hWnd, nCmdShow);
}

late final _ShowWindow = _user32
    .lookup<ffi.NativeFunction<BOOL Function(HWND, ffi.Int32)>>('ShowWindow')
    .asFunction<int Function(HWND, int)>();

int UpdateWindow(HWND hWnd) {
  return _UpdateWindow(hWnd);
}

late final _UpdateWindow = _user32
    .lookup<ffi.NativeFunction<BOOL Function(HWND)>>('UpdateWindow')
    .asFunction<int Function(HWND)>();

HICON LoadIconW(HINSTANCE hInstance, LPCWSTR lpIconName) {
  return _LoadIconW(hInstance, lpIconName);
}

late final _LoadIconW = _user32
    .lookup<ffi.NativeFunction<HICON Function(HINSTANCE, LPCWSTR)>>('LoadIconW')
    .asFunction<HICON Function(HINSTANCE, LPCWSTR)>();

HCURSOR LoadCursorW(HINSTANCE hInstance, LPCWSTR lpCursorName) {
  return _LoadCursorW(hInstance, lpCursorName);
}

late final _LoadCursorW = _user32
    .lookup<ffi.NativeFunction<HCURSOR Function(HINSTANCE, LPCWSTR)>>(
        'LoadCursorW')
    .asFunction<HCURSOR Function(HINSTANCE, LPCWSTR)>();

int DefWindowProcW(HWND hWnd, int Msg, int wParam, int lParam) {
  return _DefWindowProcW(hWnd, Msg, wParam, lParam);
}

late final _DefWindowProcW = _user32
    .lookup<ffi.NativeFunction<LRESULT Function(HWND, UINT, WPARAM, LPARAM)>>(
        'DefWindowProcW')
    .asFunction<int Function(HWND, int, int, int)>();

int GetMessageW(LPMSG lpMsg, HWND hWnd, int wMsgFilterMin, int wMsgFilterMax) {
  return _GetMessageW(lpMsg, hWnd, wMsgFilterMin, wMsgFilterMax);
}

late final _GetMessageW = _user32
    .lookup<ffi.NativeFunction<BOOL Function(LPMSG, HWND, UINT, UINT)>>(
        'GetMessageW')
    .asFunction<int Function(LPMSG, HWND, int, int)>();

int TranslateMessage(ffi.Pointer<MSG> lpMsg) {
  return _TranslateMessage(lpMsg);
}

late final _TranslateMessage = _user32
    .lookup<ffi.NativeFunction<BOOL Function(ffi.Pointer<MSG>)>>(
        'TranslateMessage')
    .asFunction<int Function(ffi.Pointer<MSG>)>();

int DispatchMessageW(ffi.Pointer<MSG> lpMsg) {
  return _DispatchMessageW(lpMsg);
}

late final _DispatchMessageW = _user32
    .lookup<ffi.NativeFunction<LRESULT Function(ffi.Pointer<MSG>)>>(
        'DispatchMessageW')
    .asFunction<int Function(ffi.Pointer<MSG>)>();

HDEVNOTIFY RegisterDeviceNotificationW(
  HANDLE hRecipient,
  LPVOID NotificationFilter,
  int Flags,
) {
  return _RegisterDeviceNotificationW(hRecipient, NotificationFilter, Flags);
}

late final _RegisterDeviceNotificationW = _user32
    .lookup<ffi.NativeFunction<HDEVNOTIFY Function(HANDLE, LPVOID, DWORD)>>(
        'RegisterDeviceNotificationW')
    .asFunction<HDEVNOTIFY Function(HANDLE, LPVOID, int)>();

int UnregisterDeviceNotification(HDEVNOTIFY Handle) {
  return _UnregisterDeviceNotification(Handle);
}

late final _UnregisterDeviceNotification = _user32
    .lookup<ffi.NativeFunction<BOOL Function(HDEVNOTIFY)>>(
        'UnregisterDeviceNotification')
    .asFunction<int Function(HDEVNOTIFY)>();
