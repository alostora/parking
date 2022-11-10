import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart' as http;
import '../../app/route_api.dart';
import '../../local_storage.dart';
import '../details/parking_details_screen.dart';

class CreateParkingScreen extends StatefulWidget {
  const CreateParkingScreen({super.key});

  @override
  State<CreateParkingScreen> createState() => _CreateParkingScreenState();
}

class _CreateParkingScreenState extends State<CreateParkingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _clientName = TextEditingController();

  final _clientCarNumber = TextEditingController();

  final _clientIdentificationNumber = TextEditingController();

  final _licenceNumber = TextEditingController();

  final _clientPhone = TextEditingController();

  int _parkingType = 0;

  final List<int> _status = [0, 1, 2];

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
      appBar: AppBar(title: const Text('Create new parking')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Parking Information',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _clientName,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                      // prefixIcon: Icon(
                      //   Icons.person,
                      //   color: Color(0xff5ac18e),
                      // ),
                      hintText: "Client Name",
                      hintStyle: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _clientCarNumber,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                      // prefixIcon: Icon(
                      //   Icons.person,
                      //   color: Color(0xff5ac18e),
                      // ),
                      hintText: "Car Number",
                      hintStyle: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _clientIdentificationNumber,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                      // prefixIcon: Icon(
                      //   Icons.person,
                      //   color: Color(0xff5ac18e),
                      // ),
                      hintText: "Identification Number",
                      hintStyle: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _licenceNumber,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                      // prefixIcon: Icon(
                      //   Icons.person,
                      //   color: Color(0xff5ac18e),
                      // ),
                      hintText: "Licence Number",
                      hintStyle: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _clientPhone,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                      // prefixIcon: Icon(
                      //   Icons.person,
                      //   color: Color(0xff5ac18e),
                      // ),
                      hintText: "Client Phone",
                      hintStyle: TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Parking Type',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                RadioGroup<int>.builder(
                  groupValue: _parkingType,
                  onChanged: (value) => setState(() {
                    _parkingType = value ?? 0;
                    debugPrint('Current parking type $value');
                  }),
                  items: _status,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item == 0
                        ? 'Valet Parking'
                        : item == 1
                            ? 'Vip Parking'
                            : 'Per Hour Parking',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      createParkingCar(
                        context,
                        _clientName.text,
                        _clientCarNumber.text,
                        _clientIdentificationNumber.text,
                        _licenceNumber.text,
                        _clientPhone.text,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        'Authorization': 'Bearer ${LocalStorage.getString(LocalStorage.apiToken)}',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(
        {
          'clientName': clientName,
          'clientCarNumber': clientCarNumber,
          'clientIdentificationNumber': clientIdentificationNumber,
          'licenceNumber': licenceNumber,
          'clientPhone': clientPhone,
          'type': _parkingType.toString()
        },
      ),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      print(jsonResponse);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParkingDetailsScreen(
            parkingId: jsonResponse['data']['id'],
          ),
        ),
      );

      debugPrint('Number of books about http: ${jsonResponse["message"]}.');
    } else {
      debugPrint('Request failed with status: ${response.body}.');
    }
  }
}
