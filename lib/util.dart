import 'package:file_manager/models.dart';
import 'package:file_manager/win32.dart' as win32;

List<Drive> getDrives() {
  return win32.GetLogicalDriveStringsW().map((name) {
    final typeNumber = win32.GetDriveTypeW(name);
    final type = DriveType.values[typeNumber];
    return Drive(name, type);
  }).toList();
}

List<int> removeCRs(List<int> bytes) {
  final removedBytes = <int>[];
  for (var i = 0; i < bytes.length - 1; i++) {
    final firstByte = bytes[i];
    final secondByte = bytes[i + 1];
    if (firstByte == 0x0d && secondByte == 0x0a) {
      continue;
    }
    removedBytes.add(firstByte);
  }
  removedBytes.add(bytes.last);
  return removedBytes;
}
