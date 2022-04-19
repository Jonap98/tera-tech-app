// To parse this JSON data, do
//
//     final clientes = clientesFromMap(jsonString);

import 'dart:convert';

Clientes clientesFromMap(String str) => Clientes.fromMap(json.decode(str));

String clientesToMap(Clientes data) => json.encode(data.toMap());

class Clientes {
  Clientes({
    required this.result,
    required this.usersCount,
    required this.datos,
  });

  bool result;
  int usersCount;
  List<DatoCliente> datos;

  factory Clientes.fromMap(Map<String, dynamic> json) => Clientes(
        result: json["result"],
        usersCount: json["users_count"],
        datos: List<DatoCliente>.from(
            json["datos"].map((x) => DatoCliente.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "users_count": usersCount,
        "datos": List<dynamic>.from(datos.map((x) => x.toMap())),
      };
}

class DatoCliente {
  DatoCliente({
    required this.id,
    required this.idRol,
    required this.name,
    required this.lastName,
    required this.email,
  });

  int id;
  int idRol;
  String name;
  String lastName;
  String email;

  factory DatoCliente.fromMap(Map<String, dynamic> json) => DatoCliente(
        id: json["id"],
        idRol: json["id_rol"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_rol": idRol,
        "name": name,
        "last_name": lastName,
        "email": email,
      };
}
