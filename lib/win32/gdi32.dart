// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:ffi' as ffi;

import 'core.dart';

final _gdi32 = ffi.DynamicLibrary.open('gdi32.dll');

const WHITE_BRUSH = 0;
const LTGRAY_BRUSH = 1;
const GRAY_BRUSH = 2;
const DKGRAY_BRUSH = 3;
const BLACK_BRUSH = 4;
const NULL_BRUSH = 5;
const HOLLOW_BRUSH = 5;

HGDIOBJ GetStockObject(int i) {
  return _GetStockObject(i);
}

late final _GetStockObject = _gdi32
    .lookup<ffi.NativeFunction<HGDIOBJ Function(ffi.Uint32 i)>>(
        'GetStockObject')
    .asFunction<HGDIOBJ Function(int i)>();
