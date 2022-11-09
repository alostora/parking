import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_parking/app/models/routes/route_api.dart';
import 'package:new_parking/views/home_page/widgets/get_parked_car/show_parcked_car.dart';

class CreateParkingCarModel {
  static void createParkingCar(
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
            'Bearer 516dc17fba2ded2a911d22b223bf0788eb4f79bb98c44552b8cd77555fe52ff0',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: convert.jsonEncode(<String, String>{
        'clientName': clientName,
        'clientCarNumber': clientCarNumber,
        'clientIdentificationNumber': clientIdentificationNumber,
        'licenceNumber': licenceNumber,
        'clientPhone': clientPhone,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

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

      print('Number of books about http: ${jsonResponse["message"]}.');
    } else {
      print('Request failed with status: ${response.body}.');
    }
  }
}
