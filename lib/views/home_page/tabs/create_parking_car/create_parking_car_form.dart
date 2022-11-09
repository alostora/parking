import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';

import 'parking_car_inputs/client_name_input.dart';
import 'parking_car_inputs/client_phone_input.dart';
import 'parking_car_inputs/parking_submit_button.dart';
import 'parking_car_inputs/client_identification_number_input.dart';
import 'parking_car_inputs/licence_number_input.dart';
import 'parking_car_inputs/client_car_number_input.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Park'),
        flexibleSpace: Container(
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
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClientNameInput.clientNameInput(_clientName),
                ClientCarNumberInput.clientCarNumberInput(_clientCarNumber),
                ClientIdentificationNumberInput.clientIdentificationNumberInput(
                    _clientIdentificationNumber),
                LicenceNumberInput.licenceNumberInput(_licenceNumber),
                ClientPhoneInput.clientPhoneInput(_clientPhone),
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
          ),
        ),
      ),
    );
  }
}
