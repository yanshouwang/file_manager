// ignore_for_file: camel_case_types, non_constant_identifier_names, constant_identifier_names

import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;

// intsafe.h
typedef CHAR = Int8;
typedef INT8 = Int8;
typedef UCHAR = Uint8;
typedef UINT8 = Uint8;
typedef BYTE = Uint8;
typedef SHORT = Int16;
typedef INT16 = Int16;
typedef USHORT = Uint16;
typedef UINT16 = Uint16;
typedef WORD = Uint16;
typedef INT = Int32;
typedef INT32 = Int32;
typedef UINT = Uint32;
typedef UINT32 = Uint32;
typedef LONG = Int32;
typedef ULONG = Uint32;
typedef DWORD = Uint32;
typedef LONGLONG = Int64;
typedef LONG64 = Int64;
typedef INT64 = Int64;
typedef ULONGLONG = Uint64;
typedef DWORDLONG = Uint64;
typedef ULONG64 = Uint64;
typedef DWORD64 = Uint64;
typedef UINT64 = Uint64;

// winnt.h
typedef wchar_t = Uint16;
typedef WCHAR = wchar_t;
typedef LPWSTR = Pointer<WCHAR>;
typedef LPCWSTR = Pointer<WCHAR>;
typedef LPSTR = Pointer<CHAR>;
typedef HANDLE = Pointer<Void>;
typedef PVOID = Pointer<Void>;

// basetsd.h
typedef LONG_PTR = Int64;
typedef UINT_PTR = Uint64;

// windef.h
typedef LRESULT = LONG_PTR;
typedef WPARAM = UINT_PTR;
typedef LPARAM = LONG_PTR;
typedef HINSTANCE = HANDLE;
typedef HMODULE = HINSTANCE;
typedef HHOOK = HANDLE;
typedef BOOL = Int32;
typedef HWND = HANDLE;
typedef HICON = HANDLE;
typedef HCURSOR = HICON;
typedef HBRUSH = HANDLE;
typedef ATOM = WORD;
typedef LPVOID = Pointer<Void>;
typedef HMENU = HANDLE;
typedef HGDIOBJ = HANDLE;
typedef POINT = tagPOINT;

class tagPOINT extends Struct {
  @LONG()
  external int x;
  @LONG()
  external int y;
}

// dbt.h
const DBT_DEVTYP_DEVICEINTERFACE = 0x00000005;
const DBT_DEVTYP_HANDLE = 0x00000006;

typedef DEV_BROADCAST_DEVICEINTERFACE_W = _DEV_BROADCAST_DEVICEINTERFACE_W;

class _DEV_BROADCAST_DEVICEINTERFACE_W extends Struct {
  @DWORD()
  external int dbcc_size;
  @DWORD()
  external int dbcc_devicetype;
  @DWORD()
  external int dbcc_reserved;
  external GUID dbcc_classguid;
  @Array(1)
  external Array<wchar_t> dbcc_name;
}

// guiddef.h
typedef GUID = _GUID;

class _GUID extends Struct {
  @Uint32()
  external int Data1;
  @Uint16()
  external int Data2;
  @Uint16()
  external int Data3;
  @Array(8)
  external Array<Uint8> Data4;

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

extension Uint16PointerX on Pointer<Uint16> {
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
  Pointer<Uint16> toNativeUint16Pointer({Allocator allocator = ffi.malloc}) {
    return toNativeUtf16(allocator: allocator).cast();
  }
}

extension Int8PointerX on Pointer<Int8> {
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
