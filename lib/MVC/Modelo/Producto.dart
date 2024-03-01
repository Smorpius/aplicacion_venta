class Producto {
  int id;
  String nombre;
  double precio;
  int cantidad;

  Producto(
      {required this.id,
      required this.nombre,
      required this.precio,
      required this.cantidad});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'cantidad': cantidad,
    };
  }
}
