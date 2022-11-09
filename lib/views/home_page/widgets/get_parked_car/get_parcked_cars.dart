import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:new_parking/views/home_page/widgets/home_page_widgets.dart';

class GetParkedCars extends StatefulWidget {
  const GetParkedCars({super.key});

  @override
  GetParkedCarsState createState() {
    return GetParkedCarsState();
  }
}

class GetParkedCarsState extends State<GetParkedCars> {
  final List<dynamic> _navigationBarElements = [
    'www',
    'sdfsdfsdf',
  ];
  Widget allCars = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        /*3*/
        Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        const Text('41'),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All cars',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),

        // SizedBox(height: 30),
        // Text('parking 1'),
        // SizedBox(height: 10),
        // Text('parking 2'),
        // SizedBox(height: 10),
        // Text('parking 3'),
        // SizedBox(height: 10),

        SingleChildScrollView(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _navigationBarElements.length,
            itemBuilder: (context, index) {
              return Text(_navigationBarElements[index]);
            },
          ),
        )
      ],
    );
  }
}
