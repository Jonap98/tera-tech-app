// To parse this JSON data, do
//
//     final roles = rolesFromMap(jsonString);

import 'dart:convert';

Roles rolesFromMap(String str) => Roles.fromMap(json.decode(str));

String rolesToMap(Roles data) => json.encode(data.toMap());

class Roles {
  Roles({
    this.roles,
  });

  List<Rol>? roles;

  factory Roles.fromMap(Map<String, dynamic> json) => Roles(
        roles: List<Rol>.from(json["roles"].map((x) => Rol.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "roles": List<dynamic>.from(roles!.map((x) => x.toMap())),
      };
}

class Rol {
  Rol({
    required this.id,
    required this.nombre,
  });

  int id;
  String nombre;

  factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
      };
}
