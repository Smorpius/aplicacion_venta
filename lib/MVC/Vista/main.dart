import 'package:aplicacion_venta/MVC/Vista/Almacen.dart';
import 'package:aplicacion_venta/MVC/Vista/SideBar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('Productos');
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
        title: Text('Clemente SHOP'),
      ),
      drawer: SideBar(),
      body: _buildScreen(_selectedNavIndex),
    );
  }
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
