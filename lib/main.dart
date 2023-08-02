import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Time',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white, fontSize: 20),
            bodyLarge: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
          )),
      home: const SplashScreen(),
    );
  }
}
