// ignore_for_file: camel_case_types, non_constant_identifier_names, constant_identifier_names

import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffi;

final NULL = ffi.nullptr;

// intsafe.h
typedef CHAR = ffi.Int8;
typedef INT8 = ffi.Int8;
typedef UCHAR = ffi.Uint8;
typedef UINT8 = ffi.Uint8;
typedef BYTE = ffi.Uint8;
typedef SHORT = ffi.Int16;
typedef INT16 = ffi.Int16;
typedef USHORT = ffi.Uint16;
typedef UINT16 = ffi.Uint16;
typedef WORD = ffi.Uint16;
typedef INT = ffi.Int32;
typedef INT32 = ffi.Int32;
typedef UINT = ffi.Uint32;
typedef UINT32 = ffi.Uint32;
typedef LONG = ffi.Int32;
typedef ULONG = ffi.Uint32;
typedef DWORD = ffi.Uint32;
typedef LONGLONG = ffi.Int64;
typedef LONG64 = ffi.Int64;
typedef INT64 = ffi.Int64;
typedef ULONGLONG = ffi.Uint64;
typedef DWORDLONG = ffi.Uint64;
typedef ULONG64 = ffi.Uint64;
typedef DWORD64 = ffi.Uint64;
typedef UINT64 = ffi.Uint64;

// winnt.h
typedef wchar_t = ffi.Uint16;
typedef WCHAR = wchar_t;
typedef LPWSTR = ffi.Pointer<WCHAR>;
typedef LPCWSTR = ffi.Pointer<WCHAR>;
typedef LPSTR = ffi.Pointer<CHAR>;
typedef HANDLE = ffi.Pointer<ffi.Void>;
typedef PVOID = ffi.Pointer<ffi.Void>;

// basetsd.h
typedef LONG_PTR = ffi.Int64;
typedef UINT_PTR = ffi.Uint64;

// windef.h
typedef LRESULT = LONG_PTR;
typedef WPARAM = UINT_PTR;
typedef LPARAM = LONG_PTR;
typedef HINSTANCE = HANDLE;
typedef HMODULE = HINSTANCE;
typedef HHOOK = HANDLE;
typedef BOOL = ffi.Int32;
typedef HWND = HANDLE;
typedef HICON = HANDLE;
typedef HCURSOR = HICON;
typedef HBRUSH = HANDLE;
typedef ATOM = WORD;
typedef LPVOID = ffi.Pointer<ffi.Void>;
typedef HMENU = HANDLE;
typedef HGDIOBJ = HANDLE;
typedef POINT = tagPOINT;
typedef LPBYTE = ffi.Pointer<BYTE>;

// winbase.h
const INFINITE = 4294967295;

typedef SECURITY_ATTRIBUTES = _SECURITY_ATTRIBUTES;
typedef LPSECURITY_ATTRIBUTES = ffi.Pointer<_SECURITY_ATTRIBUTES>;

class tagPOINT extends ffi.Struct {
  @LONG()
  external int x;
  @LONG()
  external int y;
}

class _SECURITY_ATTRIBUTES extends ffi.Struct {
  @DWORD()
  external int nLength;

  external LPVOID lpSecurityDescriptor;

  @BOOL()
  external int bInheritHandle;
}

// dbt.h
const DBT_DEVTYP_DEVICEINTERFACE = 0x00000005;
const DBT_DEVTYP_HANDLE = 0x00000006;

typedef DEV_BROADCAST_DEVICEINTERFACE_W = _DEV_BROADCAST_DEVICEINTERFACE_W;

class _DEV_BROADCAST_DEVICEINTERFACE_W extends ffi.Struct {
  @DWORD()
  external int dbcc_size;
  @DWORD()
  external int dbcc_devicetype;
  @DWORD()
  external int dbcc_reserved;
  external GUID dbcc_classguid;
  @ffi.Array(1)
  external ffi.Array<wchar_t> dbcc_name;
}

// guiddef.h
typedef GUID = _GUID;

class _GUID extends ffi.Struct {
  @ffi.Uint32()
  external int Data1;
  @ffi.Uint16()
  external int Data2;
  @ffi.Uint16()
  external int Data3;
  @ffi.Array(8)
  external ffi.Array<ffi.Uint8> Data4;

  void setValue(int data1, int data2, int data3, List<int> data4) {
    Data1 = data1;
    Data2 = data2;
    Data3 = data3;
    for (var i = 0; i < 8; i++) {
      Data4[i] = data4[i];
    }
  }
}

class Win32Exception implements Exception {
  final int statusCode;

  const Win32Exception(this.statusCode);

  @override
  String toString() {
    return '0x${statusCode.toRadixString(16)}';
  }
}

extension Uint16PointerX on ffi.Pointer<ffi.Uint16> {
  String toDartString() {
    return cast<ffi.Utf16>().toDartString();
  }

  List<String> toDartStringArray(int length) {
    final buffer = StringBuffer();
    var i = 0;
    final items = <String>[];
    while (i < length) {
      final char = elementAt(i).value;
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

extension StringX on String {
  ffi.Pointer<ffi.Uint16> toNativeUint16Pointer(
      {ffi.Allocator allocator = ffi.malloc}) {
    return toNativeUtf16(allocator: allocator).cast();
  }
}

extension Int8PointerX on ffi.Pointer<ffi.Int8> {
  String toDartString() {
    return cast<ffi.Utf8>().toDartString();
  }

  List<String> toDartStringArray(int length) {
    final codeUnits = <int>[];
    var i = 0;
    final items = <String>[];
    while (i < length) {
      final char = elementAt(i).value;
      if (char == 0) {
        final item = utf8.decode(codeUnits);
        codeUnits.clear();
        items.add(item);
      } else {
        codeUnits.add(char);
      }
      i++;
    }
    return items;
  }
}
