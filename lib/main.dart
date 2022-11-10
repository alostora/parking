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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.cyan,
        ),
      ),
      home: LocalStorage.getString(LocalStorage.apiToken) != null
          ? const MainHomePage()
          : const LoginScreen(),
    );
  }
}
