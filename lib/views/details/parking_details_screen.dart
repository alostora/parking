import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:new_parking/app/route_api.dart';
import 'package:new_parking/local_storage.dart';

class ParkingDetailsScreen extends StatefulWidget {
  final int parkingId;
  final String clientName;
  final String clientCarNumber;
  final String clientIdentificationNumber;
  final String licenceNumber;
  final String clientPhone;

  const ParkingDetailsScreen({
    super.key,
    required this.clientName,
    required this.clientCarNumber,
    required this.clientIdentificationNumber,
    required this.licenceNumber,
    required this.clientPhone,
    required this.parkingId,
  });

  @override
  State<ParkingDetailsScreen> createState() => _ParkingDetailsScreenState();
}

class _ParkingDetailsScreenState extends State<ParkingDetailsScreen> {
  String _printerStatus = 'Printer status.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_printerStatus),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Name : ${widget.clientName}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Car Number : ${widget.clientCarNumber}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Id Number : ${widget.clientIdentificationNumber}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Licence Number : ${widget.licenceNumber}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Client Phone : ${widget.clientPhone}'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('End Parking'),
                  onPressed: () async {
                    await _startPrint();
                    await endParkedCar(widget.clientName);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startPrint() async {
    String printerStatus;
    try {
      var parameters = {'print_text': 'mahmoud ashraf'};

      final bool result = await const MethodChannel('com.example.new_parking/print').invokeMethod(
        'startPrint',
        Map.from(parameters),
      );
      printerStatus = 'printer status is $result % .';
    } on PlatformException catch (e) {
      printerStatus = "Failed to get printer status: '${e.message}'.";
    }

    setState(() {
      _printerStatus = printerStatus;
    });
  }

  Future<void> endParkedCar(clientName) async {
    var url = Uri.parse(RouteApi.mainUrl + RouteApi.ednParkingCar);

    var response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer ${LocalStorage.getString(LocalStorage.apiToken)}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{'id': widget.parkingId.toString()}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      debugPrint('Number of books about http: ${jsonResponse["message"]}.');
    } else {
      debugPrint('Request failed with status: ${response.body}.');
    }
  }
}
