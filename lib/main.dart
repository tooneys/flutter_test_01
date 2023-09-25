import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_01/screens/splash_screen.dart';
import 'package:flutter_test_01/utils/notification.dart';

StreamController<String> streamController = StreamController.broadcast();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LocalNotification.onBackgroundNotificationResponse();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test 01',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
