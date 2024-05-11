import 'package:fit_check/screens/dashboard.dart';
import 'package:fit_check/screens/intro.dart';
import 'package:flutter/material.dart';

  bool isLoad=true;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoad? IntroScreen(isLoad: isLoad,):const Dashboard(),
    );
  }
}
