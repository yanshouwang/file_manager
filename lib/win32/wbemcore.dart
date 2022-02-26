import 'dart:ffi';

import 'types.dart';

final wbemcore = DynamicLibrary.open('wbemcore.dll');

late final Pointer<CLSID> CLSID_WbemLocator =
    wbemcore.lookup<CLSID>('CLSID_WbemLocator');

late final Pointer<IID> IID_IWbemLocator =
    wbemcore.lookup<IID>('IID_IWbemLocator');
