import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const ClaudeApp());
}

class ClaudeApp extends StatelessWidget {
  const ClaudeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shivri',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          elevation: 0,
        ),
      ),
      home: const BrowserWebView(),
      debugShowCheckedModeBanner: false,
    );
  }
}