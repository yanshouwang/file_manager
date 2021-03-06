import 'dart:async';
import 'dart:developer' as developer;

import 'package:file_manager/models.dart';
import 'package:file_manager/notifications.dart';
import 'package:file_manager/util.dart' as util;
import 'package:file_manager/views.dart';
import 'package:file_manager/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart' as window_size;

void main() {
  runZonedGuarded(onStarted, onCrashed);
}

void onStarted() {
  const app = MyApp();
  runApp(app);
  fixWindow();
}

void fixWindow() async {
  window_size.setWindowTitle('This PC');
  const size = Size(800, 600);
  window_size.setWindowMinSize(size);

  util.runMessagesIsolate();
}

void onCrashed(Object error, StackTrace stack) {
  developer.log('Crashed: $error\n$stack');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ValueNotifier<Settings> settingsNotifier;

  @override
  void initState() {
    super.initState();
    settingsNotifier = ValueNotifier(Settings.undefined);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NotificationListener<Notification>(
      onNotification: (notification) => onNotified(context, notification),
      child: ValueListenableBuilder<Settings>(
        valueListenable: settingsNotifier,
        builder: (context, settings, child) {
          return SettingsWidget(
            settings: settings,
            child: MaterialApp(
              title: 'File Manager',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                brightness: Brightness.light,
                primarySwatch: Colors.green,
                platform: TargetPlatform.macOS,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.green,
                platform: TargetPlatform.macOS,
              ),
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              home: const HomeView(),
              themeMode: settings.themeMode,
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    settingsNotifier.dispose();
    super.dispose();
  }

  bool onNotified(BuildContext context, Notification notification) {
    if (notification is SettingsNotification) {
      settingsNotifier.value = notification.value;
    }
    return true;
  }
}
