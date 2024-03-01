import 'package:aplicacion_venta/MVC/Modelo/Producto.dart';
import 'package:flutter/material.dart';

class VentasScreen extends StatefulWidget {
  final List<Producto> productosEnAlmacen;

  VentasScreen({required this.productosEnAlmacen});

  @override
  _VentasScreenState createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  List<Producto> productosEnVentas = [];

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
            // Lista de productos en ventas
            Expanded(
              child: ListView.builder(
                itemCount: productosEnVentas.length,
                itemBuilder: (context, index) {
                  final producto = productosEnVentas[index];
                  return ListTile(
                    title: Text('${producto.nombre} (ID: ${producto.id})'),
                    subtitle:
                        Text('Precio: \$${producto.precio.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Productos en el Almacén',
              style: TextStyle(fontSize: 18.0),
            ),
            // manda a llamar a una lista de controlador almacen
            Expanded(
              child: ListView.builder(
                itemCount: widget.productosEnAlmacen.length,
                itemBuilder: (context, index) {
                  final producto = widget.productosEnAlmacen[index];
                  return ListTile(
                    title: Text('${producto.nombre} (ID: ${producto.id})'),
                    subtitle:
                        Text('Precio: \$${producto.precio.toStringAsFixed(2)}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _agregarProductoAVentas(producto);
                      },
                      child: Text('Agregar'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _agregarProductoAVentas(Producto producto) {
    setState(() {
      productosEnVentas.add(producto);
    });
  }
}
