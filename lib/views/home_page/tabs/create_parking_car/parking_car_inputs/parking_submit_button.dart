import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_parking/app/route_api.dart';
import 'package:new_parking/local_storage.dart';
import 'package:new_parking/views/details/park_details.dart';
import 'package:http/http.dart' as http;

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
            createParkingCar(
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

  createParkingCar(
    context,
    clientName,
    clientCarNumber,
    clientIdentificationNumber,
    licenceNumber,
    clientPhone,
  ) async {
    var url = Uri.parse(RouteApi.mainUrl + RouteApi.parkingCar);

    var response = await http.post(
      url,
      headers: <String, String>{
        'Authorization':
            'Bearer ${LocalStorage.getString(LocalStorage.apiToken)}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'clientName': clientName,
        'clientCarNumber': clientCarNumber,
        'clientIdentificationNumber': clientIdentificationNumber,
        'licenceNumber': licenceNumber,
        'clientPhone': clientPhone,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      //generate printer

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowParkedCarPage(
            clientName: clientName,
            clientCarNumber: clientCarNumber,
            clientIdentificationNumber: clientIdentificationNumber,
            licenceNumber: licenceNumber,
            clientPhone: clientPhone,
          ),
        ),
      );

      debugPrint('Number of books about http: ${jsonResponse["message"]}.');
    } else {
      debugPrint('Request failed with status: ${response.body}.');
    }
  }
}
