import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_parking/views/general_widgets/general_drower.dart';
import 'package:new_parking/views/home_page/widgets/home_page_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String _title = 'Parking';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _navigationBarElements = HomePageWidgets.listElements();
  final List<BottomNavigationBarItem> _navigationBar =
      HomePageWidgets.navigationBar();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
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
                child: _navigationBarElements.elementAt(_selectedIndex),
              ),
            ),
          ],
        ),
      ),
      drawer: GeneralDrower.generalDrower(context),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
