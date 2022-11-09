import 'package:flutter/material.dart';

class AllParkingScreen extends StatefulWidget {
  const AllParkingScreen({super.key});

  @override
  AllParkingScreenState createState() {
    return AllParkingScreenState();
  }
}

class AllParkingScreenState extends State<AllParkingScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Cars'),
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
      body: ListView.builder(
        itemCount: _navigationBarElements.length,
        itemBuilder: (context, index) {
          return Text(_navigationBarElements[index]);
        },
      ),
    );
  }
}
