import 'package:flutter/material.dart';
import 'package:kurerefinancialplanner_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Kureres Financial Planner',
      theme: ThemeData(
        fontFamily: 'SFPro',
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
