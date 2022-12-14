import 'package:flutter/material.dart';
import 'package:news_app/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lightning News App',
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Colors.transparent, centerTitle: true),
      ),
      home: const HomePage(),
    );
  }
}
