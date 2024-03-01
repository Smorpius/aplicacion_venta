import 'package:aplicacion_venta/MVC/Modelo/Producto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ControladorAlmacen {
  var productos = <Producto>[];
  var productosbox = Hive.box('productos');

  List<Producto> obtenerProductos() {
    var productos = Hive.box('productos');
    List<Producto> listaProductos = [];
    for (var key in productos.keys) {
      var producto = productos.get(key);
      listaProductos.add(Producto(
        id: producto['id'],
        nombre: producto['nombre'],
        precio: producto['precio'],
        cantidad: producto['cantidad'],
      ));
    }
    this.productos =
        listaProductos; // Actualiza la lista de productos en memoria
    return listaProductos;
  }

  bool registrarProducto(Producto producto) {
    try {
      productos.add(producto);
      productosbox.put(producto.id, producto.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  bool modificarProducto(Producto producto) {
    try {
      productosbox.put(producto.id, producto.toMap());
      // Actualiza el producto en la lista de productos en memoria
      int index = productos.indexWhere((p) => p.id == producto.id);
      if (index != -1) {
        productos[index] = producto;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  bool eliminarProducto(Producto producto) {
    try {
      productosbox.delete(producto.id);
      // Elimina el producto de la lista de productos en memoria
      productos.removeWhere((p) => p.id == producto.id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
