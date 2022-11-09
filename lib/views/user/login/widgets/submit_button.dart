import 'package:flutter/material.dart';
import 'package:new_parking/app/models/user/login_model.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.phone, required this.password});

  final TextEditingController phone;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            LoginModel.login(context, phone.text, password.text);
          },
        ));
  }
}
