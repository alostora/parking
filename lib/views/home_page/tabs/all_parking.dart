import 'package:flutter/material.dart';

import '../../create_parking/create_parking.dart';

class AllParkingScreen extends StatefulWidget {
  const AllParkingScreen({super.key});

  @override
  State<AllParkingScreen> createState() => _AllParkingScreenState();
}

class _AllParkingScreenState extends State<AllParkingScreen> {
  final List<dynamic> _allCars = [
    'Car 1',
    'Car 2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Cars')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateParkingScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              child: ListTile(
                leading: const Icon(Icons.car_repair, size: 40),
                title: Text('Car ${index + 1}', style: Theme.of(context).textTheme.labelLarge),
                subtitle: Text('Mahmoud Ashraf', style: Theme.of(context).textTheme.caption),
              ),
            );
          },
        ),
      ),
    );
  }
}
