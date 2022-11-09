import 'package:flutter/material.dart';
import 'package:new_parking/views/home_page/widgets/create_parking_car/parking_car_inputs/client_car_number_input.dart';
import 'package:new_parking/views/home_page/widgets/create_parking_car/parking_car_inputs/client_identification_number_input.dart';
import 'package:new_parking/views/home_page/widgets/create_parking_car/parking_car_inputs/client_name_input.dart';
import 'package:new_parking/views/home_page/widgets/create_parking_car/parking_car_inputs/client_phone_input.dart';
import 'package:new_parking/views/home_page/widgets/create_parking_car/parking_car_inputs/licence_number_input.dart';
import 'package:new_parking/views/home_page/widgets/create_parking_car/parking_car_inputs/parking_submit_button.dart';

import 'dart:async';
import 'package:flutter/services.dart';

class CreateParkingCarForm extends StatefulWidget {
  const CreateParkingCarForm({super.key});

  @override
  CreateParkingCarFormState createState() {
    return CreateParkingCarFormState();
  }
}

class CreateParkingCarFormState extends State<CreateParkingCarForm> {
  static const platform = MethodChannel('com.example.new_parking/print');

  String _batteryLevel = 'Unknown printer status.';

  Future<void> _startPrint() async {
    String batteryLevel;
    try {
      final dynamic result = await platform.invokeMethod('startPrint');
      batteryLevel = 'printer status is $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get printer status: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _clientName = TextEditingController();
  final _clientCarNumber = TextEditingController();
  final _clientIdentificationNumber = TextEditingController();
  final _licenceNumber = TextEditingController();
  final _clientPhone = TextEditingController();

  @override
  void dispose() {
    _clientName.dispose();
    _clientCarNumber.dispose();
    _clientIdentificationNumber.dispose();
    _licenceNumber.dispose();
    _clientPhone.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New parking',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          ClientNameInput.clientNameInput(_clientName),
          const SizedBox(height: 10),
          ClientCarNumberInput.clientCarNumberInput(_clientCarNumber),
          const SizedBox(height: 10),
          ClientIdentificationNumberInput.clientIdentificationNumberInput(
              _clientIdentificationNumber),
          const SizedBox(height: 10),
          LicenceNumberInput.licenceNumberInput(_licenceNumber),
          const SizedBox(height: 10),
          ClientPhoneInput.clientPhoneInput(_clientPhone),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ParkingSubmitButton(
              clientName: _clientName,
              clientCarNumber: _clientCarNumber,
              clientIdentificationNumber: _clientIdentificationNumber,
              licenceNumber: _licenceNumber,
              clientPhone: _clientPhone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: ElevatedButton(
              onPressed: _startPrint,
              child: const Text('printer status'),
            ),
          ),
          Text(_batteryLevel),
        ],
      ),
    );
  }
}
