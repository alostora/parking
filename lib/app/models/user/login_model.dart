import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:new_parking/app/models/routes/route_api.dart';
import 'package:new_parking/views/home_page/home_page.dart';

class LoginModel {
  static void login(context, phone, password) async {
    var url = Uri.parse(RouteApi.mainUrl + RouteApi.login);

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, String>{
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      var token = jsonResponse['data']['token'];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );

      print('token: $token.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
