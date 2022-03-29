// To parse this JSON data, do
//
//     final categorias = categoriasFromMap(jsonString);

import 'dart:convert';

Categorias categoriasFromMap(String str) =>
    Categorias.fromMap(json.decode(str));

String categoriasToMap(Categorias data) => json.encode(data.toMap());

class Categorias {
  Categorias({
    required this.result,
    required this.datos,
  });

  bool result;
  List<DatoCategoria> datos;

  factory Categorias.fromMap(Map<String, dynamic> json) => Categorias(
        result: json["result"],
        datos: List<DatoCategoria>.from(
            json["datos"].map((x) => DatoCategoria.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "datos": List<dynamic>.from(datos.map((x) => x.toMap())),
      };
}

class DatoCategoria {
  DatoCategoria({
    required this.id,
    required this.nombre,
  });

  int id;
  String nombre;

  factory DatoCategoria.fromMap(Map<String, dynamic> json) => DatoCategoria(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}
