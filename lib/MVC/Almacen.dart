import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlmacenScreen extends StatefulWidget {
  @override
  _AlmacenScreenState createState() => _AlmacenScreenState();
}

class Producto {
  final String id;
  String nombre;
  double precio;
  int cantidad;

  Producto(
      {required this.id,
      required this.nombre,
      required this.precio,
      required this.cantidad});
}

class _AlmacenScreenState extends State<AlmacenScreen> {
  List<Producto> productos = [];
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _precioController = TextEditingController();
  TextEditingController _cantidadController = TextEditingController();

  void _registrarProducto() {
    setState(() {
      productos.add(
        Producto(
          id: productos.length.toString(),
          nombre: _nombreController.text,
          precio: double.parse(_precioController.text),
          cantidad: int.parse(_cantidadController.text),
        ),
      );
      _limpiarCampos();
    });
  }

  void _eliminarProducto(Producto producto) {
    setState(() {
      productos.remove(producto);
    });
  }

  void _mostrarDialogoModificarProducto(Producto producto) {
    _nombreController.text = producto.nombre;
    _precioController.text = producto.precio.toString();
    _cantidadController.text = producto.cantidad.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modificar Producto'),
          content: Column(
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del producto'),
              ),
              TextField(
                controller: _precioController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Precio del producto'),
              ),
              TextField(
                controller: _cantidadController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Cantidad'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _modificarProducto(producto);
                Navigator.of(context).pop();
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        );
      },
    );
  }

  void _modificarProducto(Producto producto) {
    setState(() {
      producto.nombre = _nombreController.text;
      producto.precio = double.parse(_precioController.text);
      producto.cantidad = int.parse(_cantidadController.text);
      _limpiarCampos();
    });
  }

  void _mostrarDialogoAgregarProducto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Producto'),
          content: Column(
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del producto'),
              ),
              TextField(
                controller: _precioController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Precio del producto'),
              ),
              TextField(
                controller: _cantidadController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Cantidad'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _registrarProducto();
                Navigator.of(context).pop();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _limpiarCampos() {
    _nombreController.clear();
    _precioController.clear();
    _cantidadController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Almacén'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contenido actual
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return ListTile(
                    title: Text('${producto.nombre} (ID: ${producto.id})'),
                    subtitle: Text(
                        'Precio: \$${producto.precio.toStringAsFixed(2)}\nCantidad: ${producto.cantidad}'),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Modificar'),
                          onTap: () {
                            _mostrarDialogoModificarProducto(producto);
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Eliminar'),
                          onTap: () {
                            _eliminarProducto(producto);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogoAgregarProducto();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
