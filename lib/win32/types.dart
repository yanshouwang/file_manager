import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;

typedef HRESULT = Int64;
typedef LPVOID = Pointer<Void>;
typedef DWORD = Uint64;
typedef PVOID = Pointer<Void>;
typedef PSECURITY_DESCRIPTOR = PVOID;
typedef LONG = Int64;
typedef SOLE_AUTHENTICATION_SERVICE = tagSOLE_AUTHENTICATION_SERVICE;
typedef wchar_t = ffi.Utf16;
typedef WCHAR = wchar_t;
typedef OLECHAR = WCHAR;
typedef GUID = _GUID;
typedef IID = GUID;
typedef LPUNKNOWN = Pointer<IUnknown>;
typedef ULONG = Uint64;
typedef BSTR = Pointer<OLECHAR>;
typedef SAFEARRAY = tagSAFEARRAY;
typedef USHORT = Uint16;
typedef SAFEARRAYBOUND = tagSAFEARRAYBOUND;
typedef VARIANT = tagVARIANT;
typedef LPCWSTR = Pointer<WCHAR>;
typedef CIMTYPE = Int64;
typedef CLSID = GUID;
typedef LPWSTR = Pointer<WCHAR>;
typedef UINT = Uint32;

class tagSOLE_AUTHENTICATION_SERVICE extends Struct {
  @DWORD()
  external int dwAuthnSvc;

  @DWORD()
  external int dwAuthzSvc;

  external Pointer<OLECHAR> pPrincipalName;

  @HRESULT()
  external int hr;
}

class _GUID extends Struct {
  @Uint64()
  external int data1;

  @Uint16()
  external int data2;

  @Uint16()
  external int data3;

  @Array.multi([8])
  external Array<Uint8> data4;

  void setValue(String value) {
    final unit1 = value.substring(0, 8);
    final unit2 = value.substring(9, 13);
    final unit3 = value.substring(14, 18);
    final unit4 = value.substring(19, 21);
    final unit5 = value.substring(21, 23);
    final unit6 = value.substring(24, 26);
    final unit7 = value.substring(26, 28);
    final unit8 = value.substring(28, 30);
    final unit9 = value.substring(30, 32);
    final unit10 = value.substring(32, 34);
    final unit11 = value.substring(34);
    data1 = int.parse(unit1, radix: 16);
    data2 = int.parse(unit2, radix: 16);
    data3 = int.parse(unit3, radix: 16);
    data4[0] = int.parse(unit4, radix: 16);
    data4[1] = int.parse(unit5, radix: 16);
    data4[2] = int.parse(unit6, radix: 16);
    data4[3] = int.parse(unit7, radix: 16);
    data4[4] = int.parse(unit8, radix: 16);
    data4[5] = int.parse(unit9, radix: 16);
    data4[6] = int.parse(unit10, radix: 16);
    data4[7] = int.parse(unit11, radix: 16);
  }

  @override
  String toString() {
    final unit1 = data1.toRadixString(16).padLeft(8, '0');
    final unit2 = data2.toRadixString(16).padLeft(4, '0');
    final unit3 = data3.toRadixString(16).padLeft(4, '0');
    final unit4 = data4[0].toRadixString(16).padLeft(2, '0');
    final unit5 = data4[1].toRadixString(16).padLeft(2, '0');
    final unit6 = data4[2].toRadixString(16).padLeft(2, '0');
    final unit7 = data4[3].toRadixString(16).padLeft(2, '0');
    final unit8 = data4[4].toRadixString(16).padLeft(2, '0');
    final unit9 = data4[5].toRadixString(16).padLeft(2, '0');
    final unit10 = data4[6].toRadixString(16).padLeft(2, '0');
    final unit11 = data4[7].toRadixString(16).padLeft(2, '0');
    return '$unit1-$unit2-$unit3-$unit4$unit5-$unit6$unit7$unit8$unit9$unit10$unit11';
  }
}

class IUnknown extends Struct {
  external Pointer<IUnknownVtbl> lpVtbl;
}

class IUnknownVtbl extends Struct {
  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IUnknown>, Pointer<IID>, Pointer<Pointer<Void>>)>>
      QueryInterface;

  external Pointer<NativeFunction<ULONG Function(Pointer<IUnknown>)>> AddRef;

  external Pointer<NativeFunction<ULONG Function(Pointer<IUnknown>)>> Release;
}

class IWbemLocator extends Struct {
  external Pointer<IWbemLocatorVtbl> lpVtbl;
}

class IWbemLocatorVtbl extends Struct {
  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IWbemLocator>, Pointer<IID>, Pointer<Pointer<Void>>)>>
      QueryInterface;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemLocator>)>>
      AddRef;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemLocator>)>>
      Release;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemLocator>,
              BSTR,
              BSTR,
              BSTR,
              BSTR,
              Int64,
              BSTR,
              Pointer<IWbemContext>,
              Pointer<Pointer<IWbemServices>>)>> ConnectServer;
}

class IWbemContext extends Struct {
  external Pointer<IWbemContextVtbl> lpVtbl;
}

class IWbemContextVtbl extends Struct {
  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IWbemContext>, Pointer<IID>, Pointer<Pointer<Void>>)>>
      QueryInterface;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemContext>)>>
      AddRef;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemContext>)>>
      Release;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemContext>, Pointer<Pointer<IWbemContext>>)>> Clone;

  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IWbemContext>, Int64, Pointer<Pointer<SAFEARRAY>>)>>
      GetNames;

  external Pointer<
          NativeFunction<HRESULT Function(Pointer<IWbemContext>, Int64)>>
      BeginEnumeration;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemContext>, Int64, Pointer<BSTR>,
              Pointer<VARIANT>)>> Next;

  external Pointer<NativeFunction<HRESULT Function(Pointer<IWbemContext>)>>
      EndEnumeration;

  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IWbemContext>, LPCWSTR, Int64, Pointer<VARIANT>)>>
      SetValue;

  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IWbemContext>, LPCWSTR, Int64, Pointer<VARIANT>)>>
      GetValue;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemContext>, LPCWSTR, Int64)>> DeleteValue;

  external Pointer<NativeFunction<HRESULT Function(Pointer<IWbemContext>)>>
      DeleteAll;
}

class tagSAFEARRAY extends Struct {
  @USHORT()
  external int cDims;

  @USHORT()
  external int fFeatures;

  @ULONG()
  external int cbElements;

  @ULONG()
  external int cLocks;

  external PVOID pvData;

  @Array.multi([1])
  external Array<SAFEARRAYBOUND> rgsabound;
}

class tagSAFEARRAYBOUND extends Struct {
  @ULONG()
  external int cElements;

  @LONG()
  external int lLbound;
}

class tagVARIANT extends Opaque {}

class IWbemServices extends Struct {
  external Pointer<IWbemServicesVtbl> lpVtbl;
}

class IWbemServicesVtbl extends Struct {
  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemServices>, Pointer<IID>,
              Pointer<Pointer<Void>>)>> QueryInterface;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemServices>)>>
      AddRef;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemServices>)>>
      Release;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IWbemServices>>,
              Pointer<Pointer<IWbemCallResult>>)>> OpenNamespace;

  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IWbemServices>, Pointer<IWbemObjectSink>)>>
      CancelAsyncCall;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemServices>, Int64,
              Pointer<Pointer<IWbemObjectSink>>)>> QueryObjectSink;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IWbemClassObject>>,
              Pointer<Pointer<IWbemCallResult>>)>> GetObjectA;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemServices>, BSTR, Int64,
              Pointer<IWbemContext>, Pointer<IWbemObjectSink>)>> GetObjectAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              Pointer<IWbemClassObject>,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IWbemCallResult>>)>> PutClass;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              Pointer<IWbemClassObject>,
              Int64,
              Pointer<IWbemContext>,
              Pointer<IWbemObjectSink>)>> PutClassAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IWbemCallResult>>)>> DeleteClass;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<IWbemObjectSink>)>> DeleteClassAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IEnumWbemClassObject>>)>> CreateClassEnum;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<IWbemObjectSink>)>> CreateClassEnumAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              Pointer<IWbemClassObject>,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IWbemCallResult>>)>> PutInstance;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              Pointer<IWbemClassObject>,
              Int64,
              Pointer<IWbemContext>,
              Pointer<IWbemObjectSink>)>> PutInstanceAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IWbemCallResult>>)>> DeleteInstance;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<IWbemObjectSink>)>> DeleteInstanceAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IEnumWbemClassObject>>)>> CreateInstanceEnum;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<IWbemObjectSink>)>> CreateInstanceEnumAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IEnumWbemClassObject>>)>> ExecQuery;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemServices>, BSTR, BSTR, Int64,
              Pointer<IWbemContext>, Pointer<IWbemObjectSink>)>> ExecQueryAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<Pointer<IEnumWbemClassObject>>)>> ExecNotificationQuery;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<IWbemObjectSink>)>> ExecNotificationQueryAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<IWbemClassObject>,
              Pointer<Pointer<IWbemClassObject>>,
              Pointer<Pointer<IWbemCallResult>>)>> ExecMethod;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemServices>,
              BSTR,
              BSTR,
              Int64,
              Pointer<IWbemContext>,
              Pointer<IWbemClassObject>,
              Pointer<IWbemObjectSink>)>> ExecMethodAsync;
}

class IWbemCallResult extends Struct {
  external Pointer<IWbemCallResultVtbl> lpVtbl;
}

class IWbemCallResultVtbl extends Struct {
  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemCallResult>, Pointer<IID>,
              Pointer<Pointer<Void>>)>> QueryInterface;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemCallResult>)>>
      AddRef;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemCallResult>)>>
      Release;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemCallResult>, Int64,
              Pointer<Pointer<IWbemClassObject>>)>> GetResultObject;

  external Pointer<
          NativeFunction<
              HRESULT Function(Pointer<IWbemCallResult>, Int64, Pointer<BSTR>)>>
      GetResultString;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemCallResult>, Int64,
              Pointer<Pointer<IWbemServices>>)>> GetResultServices;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemCallResult>, Int64, Pointer<Int64>)>> GetCallStatus;
}

class IWbemClassObject extends Struct {
  external Pointer<IWbemClassObjectVtbl> lpVtbl;
}

class IWbemClassObjectVtbl extends Struct {
  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, Pointer<IID>,
              Pointer<Pointer<Void>>)>> QueryInterface;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemClassObject>)>>
      AddRef;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemClassObject>)>>
      Release;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>,
              Pointer<Pointer<IWbemQualifierSet>>)>> GetQualifierSet;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, LPCWSTR, Int64,
              Pointer<VARIANT>, Pointer<CIMTYPE>, Pointer<Int64>)>> Get;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, LPCWSTR, Int64,
              Pointer<VARIANT>, CIMTYPE)>> Put;

  external Pointer<
          NativeFunction<HRESULT Function(Pointer<IWbemClassObject>, LPCWSTR)>>
      Delete;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, LPCWSTR, Int64,
              Pointer<VARIANT>, Pointer<Pointer<SAFEARRAY>>)>> GetNames;

  external Pointer<
          NativeFunction<HRESULT Function(Pointer<IWbemClassObject>, Int64)>>
      BeginEnumeration;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, Int64, Pointer<BSTR>,
              Pointer<VARIANT>, Pointer<CIMTYPE>, Pointer<Int64>)>> Next;

  external Pointer<NativeFunction<HRESULT Function(Pointer<IWbemClassObject>)>>
      EndEnumeration;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, LPCWSTR,
              Pointer<Pointer<IWbemQualifierSet>>)>> GetPropertyQualifierSet;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>,
              Pointer<Pointer<IWbemClassObject>>)>> Clone;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemClassObject>, Int64, Pointer<BSTR>)>> GetObjectText;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, Int64,
              Pointer<Pointer<IWbemClassObject>>)>> SpawnDerivedClass;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, Int64,
              Pointer<Pointer<IWbemClassObject>>)>> SpawnInstance;

  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IWbemClassObject>, Int64, Pointer<IWbemClassObject>)>>
      CompareTo;

  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IWbemClassObject>, LPCWSTR, Pointer<BSTR>)>>
      GetPropertyOrigin;

  external Pointer<
          NativeFunction<HRESULT Function(Pointer<IWbemClassObject>, LPCWSTR)>>
      InheritsFrom;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemClassObject>,
              LPCWSTR,
              Int64,
              Pointer<Pointer<IWbemClassObject>>,
              Pointer<Pointer<IWbemClassObject>>)>> GetMethod;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, LPCWSTR, Int64,
              Pointer<IWbemClassObject>, Pointer<IWbemClassObject>)>> PutMethod;

  external Pointer<
          NativeFunction<HRESULT Function(Pointer<IWbemClassObject>, LPCWSTR)>>
      DeleteMethod;

  external Pointer<
          NativeFunction<HRESULT Function(Pointer<IWbemClassObject>, Int64)>>
      BeginMethodEnumeration;

  external Pointer<
      NativeFunction<
          HRESULT Function(
              Pointer<IWbemClassObject>,
              Int64,
              Pointer<BSTR>,
              Pointer<Pointer<IWbemClassObject>>,
              Pointer<Pointer<IWbemClassObject>>)>> NextMethod;

  external Pointer<NativeFunction<HRESULT Function(Pointer<IWbemClassObject>)>>
      EndMethodEnumeration;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemClassObject>, LPCWSTR,
              Pointer<Pointer<IWbemQualifierSet>>)>> GetMethodQualifierSet;

  external Pointer<
          NativeFunction<
              HRESULT Function(
                  Pointer<IWbemClassObject>, LPCWSTR, Pointer<BSTR>)>>
      GetMethodOrigin;
}

class IWbemQualifierSet extends Struct {
  external Pointer<IWbemQualifierSetVtbl> lpVtbl;
}

class IWbemQualifierSetVtbl extends Struct {
  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemQualifierSet>, Pointer<IID>,
              Pointer<Pointer<Void>>)>> QueryInterface;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemQualifierSet>)>>
      AddRef;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemQualifierSet>)>>
      Release;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemQualifierSet>, LPCWSTR, Int64,
              Pointer<VARIANT>, Pointer<Int64>)>> Get;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemQualifierSet>, LPCWSTR,
              Pointer<VARIANT>, Int64)>> Put;

  external Pointer<
          NativeFunction<HRESULT Function(Pointer<IWbemQualifierSet>, LPCWSTR)>>
      Delete;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemQualifierSet>, Int64,
              Pointer<Pointer<SAFEARRAY>>)>> GetNames;

  external Pointer<
          NativeFunction<HRESULT Function(Pointer<IWbemQualifierSet>, Int64)>>
      BeginEnumeration;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemQualifierSet>, Int64, Pointer<BSTR>,
              Pointer<VARIANT>, Pointer<Int64>)>> Next;

  external Pointer<NativeFunction<HRESULT Function(Pointer<IWbemQualifierSet>)>>
      EndEnumeration;
}

class IWbemObjectSink extends Struct {
  external Pointer<IWbemObjectSinkVtbl> lpVtbl;
}

class IWbemObjectSinkVtbl extends Struct {
  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemObjectSink>, Pointer<IID>,
              Pointer<Pointer<Void>>)>> QueryInterface;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemObjectSink>)>>
      AddRef;

  external Pointer<NativeFunction<ULONG Function(Pointer<IWbemObjectSink>)>>
      Release;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemObjectSink>, Int64,
              Pointer<Pointer<IWbemClassObject>>)>> Indicate;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IWbemObjectSink>, Int64, HRESULT, BSTR,
              Pointer<IWbemClassObject>)>> SetStatus;
}

class IEnumWbemClassObject extends Struct {
  external Pointer<IEnumWbemClassObjectVtbl> lpVtbl;
}

class IEnumWbemClassObjectVtbl extends Struct {
  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IEnumWbemClassObject>, Pointer<IID>,
              Pointer<Pointer<Void>>)>> QueryInterface;

  external Pointer<
      NativeFunction<ULONG Function(Pointer<IEnumWbemClassObject>)>> AddRef;

  external Pointer<
      NativeFunction<ULONG Function(Pointer<IEnumWbemClassObject>)>> Release;

  external Pointer<
      NativeFunction<HRESULT Function(Pointer<IEnumWbemClassObject>)>> Reset;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IEnumWbemClassObject>, Int64, ULONG,
              Pointer<Pointer<IWbemClassObject>>, Pointer<ULONG>)>> Next;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IEnumWbemClassObject>, ULONG,
              Pointer<IWbemObjectSink>)>> NextAsync;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IEnumWbemClassObject>,
              Pointer<Pointer<IEnumWbemClassObject>>)>> Clone;

  external Pointer<
      NativeFunction<
          HRESULT Function(Pointer<IEnumWbemClassObject>, Int64, ULONG)>> Skip;
}

extension Utf16Pointer on Pointer<ffi.Utf16> {
  List<String> toDartStringArray(int length) {
    final codeUnits = cast<Uint16>();
    final buffer = StringBuffer();
    var i = 0;
    final items = <String>[];
    while (i < length) {
      final char = codeUnits.elementAt(i).value;
      if (char == 0) {
        final item = buffer.toString();
        buffer.clear();
        items.add(item);
      } else {
        buffer.writeCharCode(char);
      }
      i++;
    }
    return items;
  }
}
