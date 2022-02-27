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

class Win32Exception implements Exception {
  final int hr;

  const Win32Exception(this.hr);

  @override
  String toString() {
    return '0x${hr.toRadixString(16)}';
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
  Pointer<Uint16> toNativeUint16Pointer() {
    return toNativeUtf16().cast();
  }
}
