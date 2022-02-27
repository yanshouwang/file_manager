import 'package:file_manager/widgets.dart';
import 'package:flutter/material.dart';

class Settings {
  final ThemeMode themeMode;

  const Settings({ThemeMode? themeMode})
      : themeMode = themeMode ?? ThemeMode.system;

  Settings copyWith({ThemeMode? themeMode}) {
    themeMode ??= this.themeMode;
    return Settings(themeMode: themeMode);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Settings && other.themeMode == themeMode;
  }

  @override
  int get hashCode => themeMode.hashCode;

  static const Settings undefined = Settings();

  static Settings of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SettingsWidget>()!
        .settings;
  }
}
