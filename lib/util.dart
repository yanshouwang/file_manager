import 'dart:developer';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffi1;
import 'package:file_manager/models.dart';
import 'package:file_manager/win32.dart' as win32;
import 'package:win32/win32.dart' as win33;

List<Drive> getDrivesByWin32() {
  return win32.GetLogicalDriveStringsW().map((name) {
    final typeNumber = win32.GetDriveTypeW(name);
    final type = DriveType.values[typeNumber];
    return Drive(name, type);
  }).toList();
}

List<Drive> getDrivesByWMI() {
  final drives = <Drive>[];

  const dwCoInit = win32.tagCOINIT.COINIT_MULTITHREADED;
  win32.CoInitializeEx(dwCoInit);

  try {
    const dwAuthnLevel = win32.RPC_C_AUTHN_LEVEL_DEFAULT;
    const dwImpLevel = win32.RPC_C_IMP_LEVEL_IMPERSONATE;
    const dwCapabilities = win32.tagEOLE_AUTHENTICATION_CAPABILITIES.EOAC_NONE;
    win32.CoInitializeSecurity(dwAuthnLevel, dwImpLevel, dwCapabilities);

    final rclsid = win32.CLSID_WbemLocator;
    final pUnkOuter = ffi.nullptr;
    const dwClsContext = win32.tagCLSCTX.CLSCTX_INPROC_SERVER;
    final riid = win32.IID_IWbemLocator;
    final rlocator = ffi1.calloc<win33.COMObject>();
    final ppv = rlocator.cast<ffi.Pointer<ffi.Void>>();

    try {
      win32.CoCreateInstance(
        rclsid,
        pUnkOuter,
        dwClsContext,
        riid,
        ppv,
      );

      final locator = win33.IWbemLocator(rlocator);

      final strNetworkResource = r'root\cimv2'.toNativeUtf16();
      final strUser = ffi.nullptr;
      final strPassword = ffi.nullptr;
      final strLocale = ffi.nullptr;
      const lSecurityFlags = win33.NULL;
      final strAuthority = ffi.nullptr;
      final pCtx = ffi.nullptr;
      final ppNamespace = ffi1.calloc<ffi.Pointer<win33.COMObject>>();
      try {
        final hr = locator.ConnectServer(
          strNetworkResource,
          strUser,
          strPassword,
          strLocale,
          lSecurityFlags,
          strAuthority,
          pCtx,
          ppNamespace,
        );
        final failed = win33.FAILED(hr);
        if (failed) {
          throw win33.WindowsException(hr);
        }

        final rService = ppNamespace.cast<win33.COMObject>();
        final service = win33.IWbemServices(rService);

        final pProxy = ppNamespace.value;
        const dwAuthnSvc = win33.RPC_C_AUTHN_WINNT;
        const dwAuthzSvc = win33.RPC_C_AUTHZ_NONE;
        final pServerPrincName = ffi.nullptr;
        const dwAuthnLevel = win32.RPC_C_AUTHN_LEVEL_CALL;
        const dwImpLevel = win32.RPC_C_IMP_LEVEL_IMPERSONATE;
        final pAuthInfo = ffi.nullptr;
        const dwCapabilities = win33.EOLE_AUTHENTICATION_CAPABILITIES.EOAC_NONE;
        try {
          final hr = win33.CoSetProxyBlanket(
            pProxy,
            dwAuthnSvc,
            dwAuthzSvc,
            pServerPrincName,
            dwAuthnLevel,
            dwImpLevel,
            pAuthInfo,
            dwCapabilities,
          );
          final failed = win33.FAILED(hr);
          if (failed) {
            throw win33.WindowsException(hr);
          }

          final strQueryLanguage = 'WQL'.toNativeUtf16();
          final strQuery = 'SELECT * FROM Win32_LogicalDisk'.toNativeUtf16();
          const lFlags = win33.WBEM_GENERIC_FLAG_TYPE.WBEM_FLAG_FORWARD_ONLY |
              win33.WBEM_GENERIC_FLAG_TYPE.WBEM_FLAG_RETURN_IMMEDIATELY;
          final pCtx = ffi.nullptr;
          final ppEnum = ffi1.calloc<ffi.Pointer<win33.COMObject>>();
          try {
            final hr = service.ExecQuery(
              strQueryLanguage,
              strQuery,
              lFlags,
              pCtx,
              ppEnum,
            );
            final failed = win33.FAILED(hr);
            if (failed) {
              throw win33.WindowsException(hr);
            }

            final renumerator = ppEnum.cast<win33.COMObject>();
            final enumerator = win33.IEnumWbemClassObject(renumerator);

            try {
              while (enumerator.ptr.address > 0) {
                const lTimeout = win33.WBEM_TIMEOUT_TYPE.WBEM_INFINITE;
                const uCount = 1;
                final rapObjects = ffi1.calloc<ffi.IntPtr>();
                final apObjects =
                    rapObjects.cast<ffi.Pointer<win33.COMObject>>();
                final puReturned = ffi1.calloc<ffi.Uint32>();
                try {
                  enumerator.Next(
                    lTimeout,
                    uCount,
                    apObjects,
                    puReturned,
                  );

                  if (puReturned.value == 0) {
                    break;
                  }

                  final rclsObj = rapObjects.cast<win33.COMObject>();
                  final clsObj = win33.IWbemClassObject(rclsObj);

                  final key1 = 'Name'.toNativeUtf16();
                  final key2 = 'VolumeName'.toNativeUtf16();
                  final key3 = 'DriveType'.toNativeUtf16();
                  final key4 = 'FileSystem'.toNativeUtf16();
                  final key5 = 'Size'.toNativeUtf16();
                  final key6 = 'FreeSpace'.toNativeUtf16();
                  const flags = 0;
                  final value1 = ffi1.calloc<win33.VARIANT>();
                  final value2 = ffi1.calloc<win33.VARIANT>();
                  final value3 = ffi1.calloc<win33.VARIANT>();
                  final value4 = ffi1.calloc<win33.VARIANT>();
                  final value5 = ffi1.calloc<win33.VARIANT>();
                  final value6 = ffi1.calloc<win33.VARIANT>();
                  final type = ffi.nullptr;
                  final flavor = ffi.nullptr;
                  try {
                    clsObj.Get(key1, flags, value1, type, flavor);
                    clsObj.Get(key2, flags, value2, type, flavor);
                    clsObj.Get(key3, flags, value3, type, flavor);
                    clsObj.Get(key4, flags, value4, type, flavor);
                    clsObj.Get(key5, flags, value5, type, flavor);
                    clsObj.Get(key6, flags, value6, type, flavor);
                    final name = value1.stringValue;
                    final volumeName = value2.stringValue;
                    final driveType = DriveType.values[value3.uint32Value];
                    final fileSystem = value4.stringValue;
                    final size = value5.stringValue;
                    final freeSpace = value6.stringValue;
                    final drive = Drive(name, driveType);
                    drives.add(drive);
                    log('LogicalDisk: $name\t$volumeName\t$driveType\t$fileSystem\t$size\t$freeSpace}');
                  } finally {
                    clsObj.Release();

                    win33.VariantClear(value1);
                    win33.VariantClear(value2);
                    win33.VariantClear(value3);
                    win33.VariantClear(value4);
                    win33.VariantClear(value5);
                    win33.VariantClear(value6);

                    ffi1.calloc.free(value1);
                    ffi1.calloc.free(value2);
                    ffi1.calloc.free(value3);
                    ffi1.calloc.free(value4);
                    ffi1.calloc.free(value5);
                    ffi1.calloc.free(value6);

                    ffi1.malloc.free(key1);
                    ffi1.malloc.free(key2);
                    ffi1.malloc.free(key3);
                    ffi1.malloc.free(key4);
                    ffi1.malloc.free(key5);
                    ffi1.malloc.free(key6);
                  }
                } finally {
                  ffi1.calloc.free(rapObjects);
                  ffi1.calloc.free(puReturned);
                }
              }
            } finally {
              enumerator.Release();
            }
          } finally {
            ffi1.malloc.free(strQueryLanguage);
            ffi1.malloc.free(strQuery);
            ffi1.calloc.free(ppEnum);
          }
        } finally {
          service.Release();
        }
      } finally {
        locator.Release();
        ffi1.malloc.free(strNetworkResource);
        ffi1.calloc.free(ppNamespace);
      }
    } finally {
      ffi1.calloc.free(rclsid);
      ffi1.calloc.free(riid);
      ffi1.calloc.free(rlocator);
    }
  } finally {
    win32.CoUninitialize();
  }

  return drives;
}

List<int> clean(List<int> bytes) {
  final cleanedBytes = <int>[];
  for (var i = 0; i < bytes.length - 1; i++) {
    final currentByte = bytes[i];
    final nextByte = bytes[i + 1];
    if (currentByte == 0x0d && nextByte == 0x0a) {
      continue;
    }
    cleanedBytes.add(currentByte);
  }
  cleanedBytes.add(bytes.last);
  return cleanedBytes;
}

extension on ffi.Pointer<win33.VARIANT> {
  String get stringValue {
    final bstrVal = ref.bstrVal;
    return bstrVal != ffi.nullptr ? bstrVal.toDartString() : '';
  }

  int get uint32Value {
    return ref.uintVal;
  }
}
