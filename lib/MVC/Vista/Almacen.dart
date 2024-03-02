import 'package:aplicacion_venta/MVC/Controlador/Controlador_Almacen.dart';
import 'package:aplicacion_venta/MVC/Modelo/Producto.dart';
import 'package:flutter/material.dart';

class AlmacenScreen extends StatefulWidget {
  @override
  _AlmacenScreenState createState() => _AlmacenScreenState();
}

class _AlmacenScreenState extends State<AlmacenScreen> {
  List<Producto> productos = [];
  ControladorAlmacen controlador = ControladorAlmacen();
  @override
  void initState() {
    productos = controlador.obtenerProductos().cast<Producto>();
    super.initState();
  }

  TextEditingController _idController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _precioController = TextEditingController();
  TextEditingController _cantidadController = TextEditingController();

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
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _modificarProducto(producto);
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        );
      },
    );
  }

  void _modificarProducto(Producto producto) {
    // Lógica para modificar un producto
    setState(() {
      producto.nombre = _nombreController.text;
      producto.precio = double.parse(_precioController.text);
      producto.cantidad = int.parse(_cantidadController.text);
      if (controlador.modificarProducto(producto)) {
        int index = productos.indexWhere((p) => p.id == producto.id);
        if (index != -1) {
          productos[index] = producto;
        }
      }
      _limpiarCampos();
    });
  }

  void _eliminarProducto(Producto producto) {
    // Lógica para eliminar un producto
    setState(() {
      if (controlador.eliminarProducto(producto)) {
        productos.removeWhere((p) => p.id == producto.id);
      }
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
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'ID del producto'),
              ),
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
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                int id = int.parse(_idController.text);
                String nombre = _nombreController.text;
                double precio = double.parse(_precioController.text);
                int cantidad = int.parse(_cantidadController.text);
                Producto producto = Producto(
                    id: id, nombre: nombre, precio: precio, cantidad: cantidad);
                if (controlador.registrarProducto(producto)) {
                  setState(() {
                    productos.add(producto);
                  });
                }

                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _limpiarCampos() {
    _idController.clear();
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
                            Navigator.pop(context); // Cerrar el menú
                            _mostrarDialogoModificarProducto(producto);
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Eliminar'),
                          onTap: () {
                            Navigator.pop(context); // Cerrar el menú
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
