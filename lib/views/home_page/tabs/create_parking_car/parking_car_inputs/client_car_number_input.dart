import 'package:flutter/material.dart';

class ClientCarNumberInput {
  static Widget clientCarNumberInput(TextEditingController clientCarNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Car No.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: TextField(
            controller: clientCarNumber,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: Colors.black87,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.person,
                color: Color(0xff5ac18e),
              ),
              hintText: "car number",
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
            ),
          ),
        ),
      ],
    );
  }
}