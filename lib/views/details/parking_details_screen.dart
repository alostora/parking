import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:new_parking/app/route_api.dart';
import 'package:new_parking/data/all_parking_response.dart';
import 'package:new_parking/local_storage.dart';

class ParkingDetailsScreen extends StatefulWidget {
  final dynamic parkingCode;
  final bool fromHome;

  const ParkingDetailsScreen({
    super.key,
    required this.parkingCode,
    this.fromHome = false,
  });

  @override
  State<ParkingDetailsScreen> createState() => _ParkingDetailsScreenState();
}

class _ParkingDetailsScreenState extends State<ParkingDetailsScreen> {
  ParkingModel? parkingModel;
  String printText = 'No Data To Be Printed!';

  @override
  void initState() {
    super.initState();
    debugPrint('Parking Details id =====>${widget.parkingCode}');
    getSinglePark(widget.parkingCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(
              //     'Parking Information',
              //     style: TextStyle(fontWeight: FontWeight.w600),
              //   ),
              // ),
              // const SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(_printerStatus),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text('Client Name : ${parkingModel?.clientName ?? ''}'),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text('Client Phone : ${parkingModel?.clientPhone ?? ''}'),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text('Car Number : ${parkingModel?.clientCarNumber ?? ''}'),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text('Id Number : ${parkingModel?.clientIdentificationNumber ?? ''}'),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text('Licence Number : ${parkingModel?.licenceNumber ?? ''}'),
              // ),
              // const Divider(
              //   color: Colors.black,
              //   thickness: 2,
              // ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Invoice',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  printText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              // const Divider(
              //   color: Colors.black,
              //   thickness: 2,
              // ),
              widget.fromHome
                  ? Container(
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
                          child: const Text('Back'),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          }),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text('End Parking'),
                          onPressed: () async {
                            await endParkedCar();
                            await _startPrint();
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startPrint() async {
    try {
      var parameters = {
        'print_text': printText,
        'parking_id': parkingModel?.code.toString(),
      };

      await const MethodChannel('com.example.new_parking/print').invokeMethod(
        'startPrint',
        Map.from(parameters),
      );
    } on PlatformException catch (e) {
      debugPrint("Failed to get printer status: '${e.message}'.");
    }

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future<void> endParkedCar() async {
    var url = Uri.parse('${RouteApi.mainUrl}${RouteApi.parkingCar}/${widget.parkingCode}');
    debugPrint(url.toString());

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer ${LocalStorage.getString(LocalStorage.apiToken)}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{'id': widget.parkingCode.toString()}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('Response=====>${jsonResponse.toString()}');
      parkingModel = ParkingModel.fromJson(jsonResponse['data']);
      printText = parkingModel?.printText ?? 'No Data To Be Printed!';
      setState(() {});
    } else {
      debugPrint('Request failed with status: ${response.body}.');
    }
  }

  void getSinglePark(dynamic parkingId) async {
    var url = Uri.parse('${RouteApi.mainUrl}${RouteApi.parkingCar}/$parkingId');

    debugPrint(url.toString());
    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer ${LocalStorage.getString(LocalStorage.apiToken)}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      debugPrint(jsonResponse.toString());
      parkingModel = ParkingModel.fromJson(jsonResponse['data']);
      printText = parkingModel?.printText ?? 'No Data To Be Printed!';
      setState(() {});
      debugPrint('Number of books about http: ${jsonResponse["message"]}.');
    } else {
      debugPrint('Request failed with status: ${response.body}.');
    }
  }
}
