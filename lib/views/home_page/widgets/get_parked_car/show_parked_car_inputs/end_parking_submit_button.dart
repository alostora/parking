import 'package:flutter/material.dart';

class EndParkedSubmitButton extends StatelessWidget {
  const EndParkedSubmitButton({
    super.key,
    required this.clientName,
    required this.onPressed,
  });

  final String clientName;
  final VoidCallback onPressed;

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
          // ignore: sort_child_properties_last
          child: const Text(
            'Create',
            style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onPressed,
        ));
  }
}
