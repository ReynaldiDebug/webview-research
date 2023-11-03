import 'package:flutter/material.dart';
import 'package:research_webview_for_retailer_conn/index-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Research Webview",
      home: IndexScreen(),
    );
  }
}
