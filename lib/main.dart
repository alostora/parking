import 'package:flutter/material.dart';
import 'package:new_parking/local_storage.dart';
import 'package:new_parking/views/home_page/home_page.dart';
import 'package:new_parking/views/login/login.dart';

void main() async {
  await LocalStorage.init();
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
      home: LocalStorage.getString(LocalStorage.apiToken) != null
          ? const MainHomePage()
          : const Login(
        title: 'Parking',
      ),
    );
  }
}
