import 'package:file_manager/models.dart';
import 'package:flutter/material.dart';

class SettingsNotification extends Notification {
  final Settings value;

  const SettingsNotification(this.value);
}
