import 'dart:ffi';

import 'errors.dart';
import 'types.dart';

final ole32 = DynamicLibrary.open('ole32.dll');

const int RPC_C_AUTHN_LEVEL_DEFAULT = 0;
const int RPC_C_AUTHN_LEVEL_NONE = 1;
const int RPC_C_AUTHN_LEVEL_CONNECT = 2;
const int RPC_C_AUTHN_LEVEL_CALL = 3;
const int RPC_C_AUTHN_LEVEL_PKT = 4;
const int RPC_C_AUTHN_LEVEL_PKT_INTEGRITY = 5;
const int RPC_C_AUTHN_LEVEL_PKT_PRIVACY = 6;

const int RPC_E_CALL_REJECTED = -2147418111;
const int RPC_E_CALL_CANCELED = -2147418110;
const int RPC_E_CANTPOST_INSENDCALL = -2147418109;
const int RPC_E_CANTCALLOUT_INASYNCCALL = -2147418108;
const int RPC_E_CANTCALLOUT_INEXTERNALCALL = -2147418107;
const int RPC_E_CONNECTION_TERMINATED = -2147418106;
const int RPC_E_SERVER_DIED = -2147418105;
const int RPC_E_CLIENT_DIED = -2147418104;
const int RPC_E_INVALID_DATAPACKET = -2147418103;
const int RPC_E_CANTTRANSMIT_CALL = -2147418102;
const int RPC_E_CLIENT_CANTMARSHAL_DATA = -2147418101;
const int RPC_E_CLIENT_CANTUNMARSHAL_DATA = -2147418100;
const int RPC_E_SERVER_CANTMARSHAL_DATA = -2147418099;
const int RPC_E_SERVER_CANTUNMARSHAL_DATA = -2147418098;
const int RPC_E_INVALID_DATA = -2147418097;
const int RPC_E_INVALID_PARAMETER = -2147418096;
const int RPC_E_CANTCALLOUT_AGAIN = -2147418095;
const int RPC_E_SERVER_DIED_DNE = -2147418094;
const int RPC_E_SYS_CALL_FAILED = -2147417856;
const int RPC_E_OUT_OF_RESOURCES = -2147417855;
const int RPC_E_ATTEMPTED_MULTITHREAD = -2147417854;
const int RPC_E_NOT_REGISTERED = -2147417853;
const int RPC_E_FAULT = -2147417852;
const int RPC_E_SERVERFAULT = -2147417851;
const int RPC_E_CHANGED_MODE = -2147417850;
const int RPC_E_INVALIDMETHOD = -2147417849;
const int RPC_E_DISCONNECTED = -2147417848;
const int RPC_E_RETRY = -2147417847;
const int RPC_E_SERVERCALL_RETRYLATER = -2147417846;
const int RPC_E_SERVERCALL_REJECTED = -2147417845;
const int RPC_E_INVALID_CALLDATA = -2147417844;
const int RPC_E_CANTCALLOUT_ININPUTSYNCCALL = -2147417843;
const int RPC_E_WRONG_THREAD = -2147417842;
const int RPC_E_THREAD_NOT_INIT = -2147417841;
const int RPC_E_VERSION_MISMATCH = -2147417840;
const int RPC_E_INVALID_HEADER = -2147417839;
const int RPC_E_INVALID_EXTENSION = -2147417838;
const int RPC_E_INVALID_IPID = -2147417837;
const int RPC_E_INVALID_OBJECT = -2147417836;
const int RPC_S_CALLPENDING = -2147417835;
const int RPC_S_WAITONTIMER = -2147417834;
const int RPC_E_CALL_COMPLETE = -2147417833;
const int RPC_E_UNSECURE_CALL = -2147417832;
const int RPC_E_TOO_LATE = -2147417831;
const int RPC_E_NO_GOOD_SECURITY_PACKAGES = -2147417830;
const int RPC_E_ACCESS_DENIED = -2147417829;
const int RPC_E_REMOTE_DISABLED = -2147417828;
const int RPC_E_INVALID_OBJREF = -2147417827;
const int RPC_E_NO_CONTEXT = -2147417826;
const int RPC_E_TIMEOUT = -2147417825;
const int RPC_E_NO_SYNC = -2147417824;
const int RPC_E_FULLSIC_REQUIRED = -2147417823;
const int RPC_E_INVALID_STD_NAME = -2147417822;

const int RPC_C_IMP_LEVEL_DEFAULT = 0;
const int RPC_C_IMP_LEVEL_ANONYMOUS = 1;
const int RPC_C_IMP_LEVEL_IDENTIFY = 2;
const int RPC_C_IMP_LEVEL_IMPERSONATE = 3;
const int RPC_C_IMP_LEVEL_DELEGATE = 4;

abstract class tagCOINITBASE {
  static const int COINITBASE_MULTITHREADED = 0;
}

abstract class tagCOINIT {
  static const int COINIT_APARTMENTTHREADED = 2;
  static const int COINIT_MULTITHREADED = 0;
  static const int COINIT_DISABLE_OLE1DDE = 4;
  static const int COINIT_SPEED_OVER_MEMORY = 8;
}

abstract class tagEOLE_AUTHENTICATION_CAPABILITIES {
  static const int EOAC_NONE = 0;
  static const int EOAC_MUTUAL_AUTH = 1;
  static const int EOAC_STATIC_CLOAKING = 32;
  static const int EOAC_DYNAMIC_CLOAKING = 64;
  static const int EOAC_ANY_AUTHORITY = 128;
  static const int EOAC_MAKE_FULLSIC = 256;
  static const int EOAC_DEFAULT = 2048;
  static const int EOAC_SECURE_REFS = 2;
  static const int EOAC_ACCESS_CONTROL = 4;
  static const int EOAC_APPID = 8;
  static const int EOAC_DYNAMIC = 16;
  static const int EOAC_REQUIRE_FULLSIC = 512;
  static const int EOAC_AUTO_IMPERSONATE = 1024;
  static const int EOAC_DISABLE_AAA = 4096;
  static const int EOAC_NO_CUSTOM_MARSHAL = 8192;
  static const int EOAC_RESERVED1 = 16384;
}

abstract class tagCLSCTX {
  static const int CLSCTX_INPROC_SERVER = 1;
  static const int CLSCTX_INPROC_HANDLER = 2;
  static const int CLSCTX_LOCAL_SERVER = 4;
  static const int CLSCTX_INPROC_SERVER16 = 8;
  static const int CLSCTX_REMOTE_SERVER = 16;
  static const int CLSCTX_INPROC_HANDLER16 = 32;
  static const int CLSCTX_RESERVED1 = 64;
  static const int CLSCTX_RESERVED2 = 128;
  static const int CLSCTX_RESERVED3 = 256;
  static const int CLSCTX_RESERVED4 = 512;
  static const int CLSCTX_NO_CODE_DOWNLOAD = 1024;
  static const int CLSCTX_RESERVED5 = 2048;
  static const int CLSCTX_NO_CUSTOM_MARSHAL = 4096;
  static const int CLSCTX_ENABLE_CODE_DOWNLOAD = 8192;
  static const int CLSCTX_NO_FAILURE_LOG = 16384;
  static const int CLSCTX_DISABLE_AAA = 32768;
  static const int CLSCTX_ENABLE_AAA = 65536;
  static const int CLSCTX_FROM_DEFAULT_CONTEXT = 131072;
  static const int CLSCTX_ACTIVATE_X86_SERVER = 262144;
  static const int CLSCTX_ACTIVATE_32_BIT_SERVER = 262144;
  static const int CLSCTX_ACTIVATE_64_BIT_SERVER = 524288;
  static const int CLSCTX_ENABLE_CLOAKING = 1048576;
  static const int CLSCTX_APPCONTAINER = 4194304;
  static const int CLSCTX_ACTIVATE_AAA_AS_IU = 8388608;
  static const int CLSCTX_RESERVED6 = 16777216;
  static const int CLSCTX_ACTIVATE_ARM32_SERVER = 33554432;
  static const int CLSCTX_PS_DLL = -2147483648;
}

// CoInitializeEx
void CoInitializeEx(int dwCoInit) {
  final hr = _CoInitializeEx(nullptr, dwCoInit);
  if (hr.failed) {
    throw Win32Exception(hr);
  }
}

late final _CoInitializeEx = ole32
    .lookup<NativeFunction<HRESULT Function(LPVOID, DWORD)>>('CoInitializeEx')
    .asFunction<int Function(LPVOID, int)>();

// CoInitializeSecurity
void CoInitializeSecurity(
  int dwAuthnLevel,
  int dwImpLevel,
  int dwCapabilities,
) {
  final hr = _CoInitializeSecurity(
    nullptr,
    -1,
    nullptr,
    nullptr,
    dwAuthnLevel,
    dwImpLevel,
    nullptr,
    dwCapabilities,
    nullptr,
  );
  if (hr.failed && hr != RPC_E_TOO_LATE) {
    throw Win32Exception(hr);
  }
}

late final _CoInitializeSecurity = ole32
    .lookup<
        NativeFunction<
            HRESULT Function(
      PSECURITY_DESCRIPTOR,
      LONG,
      Pointer<SOLE_AUTHENTICATION_SERVICE>,
      Pointer<Void>,
      DWORD,
      DWORD,
      Pointer<Void>,
      DWORD,
      Pointer<Void>,
    )>>('CoInitializeSecurity')
    .asFunction<
        int Function(
      PSECURITY_DESCRIPTOR,
      int,
      Pointer<SOLE_AUTHENTICATION_SERVICE>,
      Pointer<Void>,
      int,
      int,
      Pointer<Void>,
      int,
      Pointer<Void>,
    )>();

// CoCreateInstance
void CoCreateInstance(
  Pointer<IID> rclsid,
  LPUNKNOWN pUnkOuter,
  int dwClsContext,
  Pointer<IID> riid,
  Pointer<LPVOID> ppv,
) {
  final hr = _CoCreateInstance(
    rclsid,
    pUnkOuter,
    dwClsContext,
    riid,
    ppv,
  );
  if (hr.failed) {
    throw Win32Exception(hr);
  }
}

late final _CoCreateInstance = ole32
    .lookup<
        NativeFunction<
            HRESULT Function(
      Pointer<IID>,
      LPUNKNOWN,
      DWORD,
      Pointer<IID>,
      Pointer<LPVOID>,
    )>>('CoCreateInstance')
    .asFunction<
        int Function(
      Pointer<IID>,
      LPUNKNOWN,
      int,
      Pointer<IID>,
      Pointer<LPVOID>,
    )>();

// CoUninitialize
void CoUninitialize() {
  return _CoUninitialize();
}

late final _CoUninitialize = ole32
    .lookup<NativeFunction<Void Function()>>('CoUninitialize')
    .asFunction<void Function()>();
