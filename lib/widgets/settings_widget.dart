import 'package:file_manager/models.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends InheritedWidget {
  final Settings settings;

  const SettingsWidget({
    Key? key,
    required this.settings,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant SettingsWidget oldWidget) {
    return oldWidget.settings != settings;
  }
}
