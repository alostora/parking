import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_parking/views/user/login/widgets/password_input.dart';
import 'package:new_parking/views/user/login/widgets/phone_input.dart';
import 'package:new_parking/views/user/login/widgets/submit_button.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _phone;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x665ac18e),
                    Color(0x995ac18e),
                    Color(0xcc5ac18e),
                    Color(0xff5ac18e),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 120,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Parking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    PhoneInput.phone(_phone),
                    const SizedBox(height: 20),
                    PasswordInput.password(_password),
                    const SizedBox(height: 40),
                    SubmitButton(
                      phone: _phone,
                      password: _password,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
