// To parse this JSON data, do
//
//     final estados = estadosFromMap(jsonString);

import 'dart:convert';

Estados estadosFromMap(String str) => Estados.fromMap(json.decode(str));

String estadosToMap(Estados data) => json.encode(data.toMap());

class Estados {
  Estados({
    this.estados,
  });

  List<Estado>? estados;

  factory Estados.fromMap(Map<String, dynamic> json) => Estados(
        estados:
            List<Estado>.from(json["estados"].map((x) => Estado.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "estados": List<dynamic>.from(estados!.map((x) => x.toMap())),
      };
}

class Estado {
  Estado({
    required this.id,
    required this.nombre,
  });

  int id;
  String nombre;

  factory Estado.fromMap(Map<String, dynamic> json) => Estado(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}
