import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Producto {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String nombre;

  @HiveField(2)
  double precio;

  @HiveField(3)
  int cantidad;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.cantidad,
  });
}

class ProductoAdapter extends TypeAdapter<Producto> {
  @override
  final int typeId = 0;

  @override
  Producto read(BinaryReader reader) {
    return Producto(
      id: reader.readString(),
      nombre: reader.readString(),
      precio: reader.readDouble(),
      cantidad: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Producto obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.nombre);
    writer.writeDouble(obj.precio);
    writer.writeInt(obj.cantidad);
  }
}
