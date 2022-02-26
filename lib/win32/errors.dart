class Win32Exception implements Exception {
  final int hr;

  const Win32Exception(this.hr);

  @override
  String toString() {
    final hexValue = '0x${hr.toRadixString(16)}';
    return 'Win32 error: $hexValue';
  }
}

extension IntX on int {
  bool get failed => this < 0;
  bool get succeed => !failed;
}
