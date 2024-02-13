import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
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
                color: Colors.blue,
              ),
              child: Text(
                'Barra Lateral',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Ventas'),
              onTap: () {
                // Acción al seleccionar el botón "Ventas"
                print('¡Ventas en la barra lateral seleccionado!');
                // Push a new screen onto the stack
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VentasScreen(),
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

// New screen for "Ventas" button
class VentasScreen extends StatefulWidget {
  @override
  _VentasScreenState createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  List<String> productIDs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contenido de la pantalla de Ventas',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ingrese datos de venta',
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el primer botón
                    print('Primer botón presionado en VentasScreen');
                    _addProductID('Producto1');
                  },
                  child: Text('Agregar Producto 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el segundo botón
                    print('Segundo botón presionado en VentasScreen');
                    _addProductID('Producto2');
                  },
                  child: Text('Agregar Producto 2'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'IDs de productos agregados:',
              style: TextStyle(fontSize: 16.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productIDs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(productIDs[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addProductID(String productID) {
    setState(() {
      productIDs.add(productID);
    });
  }
}
