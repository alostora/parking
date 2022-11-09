import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:new_parking/app/route_api.dart';

class ShowParkedCarPage extends StatelessWidget {
  final dynamic clientName;
  final dynamic clientCarNumber;
  final dynamic clientIdentificationNumber;
  final dynamic licenceNumber;
  final dynamic clientPhone;

  const ShowParkedCarPage({
    super.key,
    required this.clientName,
    required this.clientCarNumber,
    required this.clientIdentificationNumber,
    required this.licenceNumber,
    required this.clientPhone,
  });

  static const String _title = 'Parked car';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: ParkDetailsScreen(
        clientName: clientName,
        clientCarNumber: clientCarNumber,
        clientIdentificationNumber: clientIdentificationNumber,
        licenceNumber: licenceNumber,
        clientPhone: clientPhone,
      ),
    );
  }
}

class ParkDetailsScreen extends StatefulWidget {
  final String clientName;
  final String clientCarNumber;
  final String clientIdentificationNumber;
  final String licenceNumber;
  final String clientPhone;

  const ParkDetailsScreen({
    super.key,
    required this.clientName,
    required this.clientCarNumber,
    required this.clientIdentificationNumber,
    required this.licenceNumber,
    required this.clientPhone,
  });

  @override
  ParkDetailsScreenState createState() {
    // ignore: no_logic_in_create_state
    return ParkDetailsScreenState(
      clientName: clientName,
      clientCarNumber: clientCarNumber,
      clientIdentificationNumber: clientIdentificationNumber,
      clientPhone: clientPhone,
      licenceNumber: licenceNumber,
    );
  }
}

class ParkDetailsScreenState extends State<ParkDetailsScreen> {
  String clientName;
  String clientCarNumber;
  String clientIdentificationNumber;
  String licenceNumber;
  String clientPhone;

  ParkDetailsScreenState({
    required this.clientName,
    required this.clientCarNumber,
    required this.clientIdentificationNumber,
    required this.licenceNumber,
    required this.clientPhone,
  });

  String _batteryLevel = 'Unknown printer status.';

  Future<void> startPrint() async {
    String batteryLevel;
    try {
      final dynamic result =
          await const MethodChannel('com.example.new_parking/print')
              .invokeMethod('startPrint');
      batteryLevel = 'printer status is $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get printer status: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
      clientName = clientName;
      clientCarNumber = clientCarNumber;
      clientIdentificationNumber = clientIdentificationNumber;
      licenceNumber = licenceNumber;
      clientPhone = clientPhone;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking'),
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
      body: Container(
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
            vertical: 70,
          ),
          child: Form(
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
                const SizedBox(height: 10),
                Text(_batteryLevel),
                Text(clientName),
                Text(clientCarNumber),
                Text(clientIdentificationNumber),
                Text(licenceNumber),
                Text(clientPhone),
                Container(
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
                      onPressed: () async {
                        await startPrint();
                        await endParkedCar(clientName);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> endParkedCar(clientName) async {
    var url = Uri.parse(RouteApi.mainUrl + RouteApi.parkingCar);

    var response = await http.post(
      url,
      headers: <String, String>{
        'Authorization':
            'Bearer 516dc17fba2ded2a911d22b223bf0788eb4f79bb98c44552b8cd77555fe52ff0',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'clientName': clientName,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      //generate printer

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const ShowParckedCar(),
      //   ),
      // );

      debugPrint('Number of books about http: ${jsonResponse["message"]}.');
    } else {
      debugPrint('Request failed with status: ${response.body}.');
    }
  }
}
