import 'package:aplicacion_venta/MVC/Vista/Almacen.dart';
import 'package:aplicacion_venta/MVC/Vista/Ventas.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Punto de venta'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Inicio',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Ventas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VentasScreen(
                      productosEnAlmacen: [],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Almacen'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlmacenScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
