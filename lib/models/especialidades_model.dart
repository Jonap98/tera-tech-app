// To parse this JSON data, do
//
//     final especialidades = especialidadesFromMap(jsonString);

import 'dart:convert';

Especialidades especialidadesFromMap(String str) =>
    Especialidades.fromMap(json.decode(str));

String especialidadesToMap(Especialidades data) => json.encode(data.toMap());

class Especialidades {
  Especialidades({
    this.especialidades,
  });

  List<Especialidad>? especialidades;

  factory Especialidades.fromMap(Map<String, dynamic> json) => Especialidades(
        especialidades: List<Especialidad>.from(
            json["especialidades"].map((x) => Especialidad.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "especialidades":
            List<dynamic>.from(especialidades!.map((x) => x.toMap())),
      };
}

class Especialidad {
  Especialidad({
    required this.id,
    required this.nombre,
  });

  int id;
  String nombre;

  factory Especialidad.fromMap(Map<String, dynamic> json) => Especialidad(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}
