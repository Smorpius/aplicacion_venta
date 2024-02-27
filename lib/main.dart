import 'package:aplicacion_venta/MVC/Almacen.dart';
import 'package:aplicacion_venta/MVC/SideBar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Punto de venta'),
      ),
      drawer: SideBar(
        onNavItemTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });

          _navigateToScreen(context, index);
        },
        navItems: [],
      ),
      body: _buildScreen(_selectedNavIndex),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return AlmacenScreen();
      default:
        return Container();
    }
  }

  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlmacenScreen(),
          ),
        );
        break;
    }
  }
}
