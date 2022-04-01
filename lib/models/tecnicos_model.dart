// To parse this JSON data, do
//
//     final tecnicos = tecnicosFromMap(jsonString);

import 'dart:convert';

Tecnicos tecnicosFromMap(String str) => Tecnicos.fromMap(json.decode(str));

String tecnicosToMap(Tecnicos data) => json.encode(data.toMap());

class Tecnicos {
  Tecnicos({
    required this.result,
    required this.usersCount,
    required this.datos,
  });

  bool result;
  int usersCount;
  List<DatoTecnico> datos;

  factory Tecnicos.fromMap(Map<String, dynamic> json) => Tecnicos(
        result: json["result"],
        usersCount: json["users_count"],
        datos: List<DatoTecnico>.from(
            json["datos"].map((x) => DatoTecnico.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "users_count": usersCount,
        "datos": List<dynamic>.from(datos.map((x) => x.toMap())),
      };
}

class DatoTecnico {
  DatoTecnico({
    required this.idRol,
    required this.idEspecialidad,
    required this.name,
    required this.lastName,
    required this.email,
    required this.especialidad,
  });

  int idRol;
  int idEspecialidad;
  String name;
  String lastName;
  String email;
  String especialidad;

  factory DatoTecnico.fromMap(Map<String, dynamic> json) => DatoTecnico(
        idRol: json["id_rol"],
        idEspecialidad: json["id_especialidad"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        especialidad: json["especialidad"],
      );

  Map<String, dynamic> toMap() => {
        "id_rol": idRol,
        "id_especialidad": idEspecialidad,
        "name": name,
        "last_name": lastName,
        "email": email,
        "especialidad": especialidad,
      };
}
