import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FloraCareApp());
}

class FloraCareApp extends StatelessWidget {
  const FloraCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FloraCare',
      debugShowCheckedModeBanner: false, // إخفاء شريط Debug
      theme: ThemeData(
        // استخدام اللون الأخضر بشكل أساسي
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const HomeScreen(), // توجيه التطبيق للشاشة الرئيسية
    );
  }
}