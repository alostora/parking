import 'package:flutter/material.dart';
import 'package:new_parking/views/home_page/home_page.dart';
import 'package:new_parking/views/user/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(
        title: 'Parking',
      ),
    );
  }
}
