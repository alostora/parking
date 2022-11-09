import 'package:flutter/material.dart';
import 'package:new_parking/app/models/parcked_car/create_parking_car_model.dart';

class ParkingSubmitButton extends StatelessWidget {
  const ParkingSubmitButton({
    super.key,
    required this.clientName,
    required this.clientCarNumber,
    required this.clientIdentificationNumber,
    required this.licenceNumber,
    required this.clientPhone,
  });

  final TextEditingController clientName;
  final TextEditingController clientCarNumber;
  final TextEditingController clientIdentificationNumber;
  final TextEditingController licenceNumber;
  final TextEditingController clientPhone;

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
            'Create',
            style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            CreateParkingCarModel.createParkingCar(
              context,
              clientName.text,
              clientCarNumber.text,
              clientIdentificationNumber.text,
              licenceNumber.text,
              clientPhone.text,
            );
          },
        ));
  }
}
