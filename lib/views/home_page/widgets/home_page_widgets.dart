import 'package:flutter/material.dart';
import 'package:new_parking/views/home_page/widgets/create_parking_car/create_parking_car_form.dart';

import 'get_parked_car/get_parcked_cars.dart';

class HomePageWidgets {
  static List<Widget> listElements() {
    return <Widget>[
      const GetParkedCars(),
      //const CreateParkingCarForm(),
      const CreateParkingCarForm(),
    ];
  }

  static List<BottomNavigationBarItem> navigationBar() {
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business',
      ),
    ];
  }
}
