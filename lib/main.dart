// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_todo/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos APP',
      theme: ThemeData(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFf6f5ee),
      ),
      home: HomePage(),
    );
  }
}
