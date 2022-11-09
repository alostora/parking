import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_parking/views/general_widgets/general_drower.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:new_parking/views/home_page/widgets/get_parked_car/show_parked_car_inputs/end_parking_submit_button.dart';
import 'package:http/http.dart' as http;
import '../../../../app/models/routes/route_api.dart';

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
      home: ShowParkedCar(
        clientName: clientName,
        clientCarNumber: clientCarNumber,
        clientIdentificationNumber: clientIdentificationNumber,
        licenceNumber: licenceNumber,
        clientPhone: clientPhone,
      ),
    );
  }
}

class ShowParkedCar extends StatefulWidget {
  final String clientName;
  final String clientCarNumber;
  final String clientIdentificationNumber;
  final String licenceNumber;
  final String clientPhone;

  const ShowParkedCar({
    super.key,
    required this.clientName,
    required this.clientCarNumber,
    required this.clientIdentificationNumber,
    required this.licenceNumber,
    required this.clientPhone,
  });

  @override
  ShowParkedCarState createState() {
    // ignore: no_logic_in_create_state
    return ShowParkedCarState(
      clientName: clientName,
      clientCarNumber: clientCarNumber,
      clientIdentificationNumber: clientIdentificationNumber,
      clientPhone: clientPhone,
      licenceNumber: licenceNumber,
    );
  }
}

class ShowParkedCarState extends State<ShowParkedCar> {
  String clientName;
  String clientCarNumber;
  String clientIdentificationNumber;
  String licenceNumber;
  String clientPhone;

  ShowParkedCarState({
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
      final dynamic result = await const MethodChannel('com.example.new_parking/print').invokeMethod('startPrint');
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: EndParkedSubmitButton(
                          clientName: clientName,
                          onPressed: () async {
                           await startPrint();
                            await endParkedCar(clientName);
                            //Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: GeneralDrower.generalDrower(context),
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

      print('Number of books about http: ${jsonResponse["message"]}.');
    } else {
      print('Request failed with status: ${response.body}.');
    }
  }
}
