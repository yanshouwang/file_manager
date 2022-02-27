import 'dart:async';
import 'dart:developer';

import 'package:file_manager/views.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(onStarted, onCrashed);
}

void onStarted() {
  const app = MyApp();
  runApp(app);
}

void onCrashed(Object error, StackTrace stack) {
  log('Crashed: $error\n$stack');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        primarySwatch: Colors.amber,
        platform: TargetPlatform.iOS,
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      home: const HomeView(),
    );
  }
}
