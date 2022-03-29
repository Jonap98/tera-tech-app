// To parse this JSON data, do
//
//     final solicitudesResponse = solicitudesResponseFromMap(jsonString);

import 'dart:convert';

SolicitudesResponse solicitudesResponseFromMap(String str) =>
    SolicitudesResponse.fromMap(json.decode(str));

String solicitudesResponseToMap(SolicitudesResponse data) =>
    json.encode(data.toMap());

class SolicitudesResponse {
  SolicitudesResponse({
    required this.result,
    required this.solicitudesCount,
    required this.user,
    required this.datos,
  });

  bool result;
  int solicitudesCount;
  SolicitudesResponseUser user;
  List<Dato> datos;

  factory SolicitudesResponse.fromMap(Map<String, dynamic> json) =>
      SolicitudesResponse(
        result: json["result"],
        solicitudesCount: json["solicitudes_count"],
        user: SolicitudesResponseUser.fromMap(json["user"]),
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "solicitudes_count": solicitudesCount,
        "user": user.toMap(),
        "datos": List<dynamic>.from(datos.map((x) => x.toMap())),
      };
}

class Dato {
  Dato({
    required this.idUsuario,
    required this.idCategoria,
    required this.idEstado,
    this.idTecnico,
    required this.descripcion,
    required this.fechaCita,
    this.imagen,
    this.comentario,
    this.fechaListo,
    this.fechaReal,
    required this.nombre,
    required this.estado,
    required this.name,
    required this.lastName,
  });

  int idUsuario;
  int idCategoria;
  int idEstado;
  int? idTecnico;
  String descripcion;
  String fechaCita;
  String? imagen;
  String? comentario;
  DateTime? fechaListo;
  DateTime? fechaReal;
  String nombre;
  String estado;
  String name;
  String lastName;

  factory Dato.fromMap(Map<String, dynamic> json) => Dato(
        idUsuario: json["id_usuario"],
        idCategoria: json["id_categoria"],
        idEstado: json["id_estado"],
        idTecnico: json["id_tecnico"],
        descripcion: json["descripcion"],
        fechaCita: json["fecha_cita"],
        // fechaCita: DateTime.parse(json["fecha_cita"]),
        imagen: json["imagen"],
        comentario: json["comentario"],
        fechaListo: json["fecha_listo"],
        fechaReal: json["fecha_real"],
        nombre: json["nombre"],
        estado: json["estado"],
        name: json["name"],
        lastName: json["last_name"],
      );

  // Formato de fechas generados por Quicktype
  Map<String, dynamic> toMap() => {
        "id_usuario": idUsuario,
        "id_categoria": idCategoria,
        "id_estado": idEstado,
        "id_tecnico": idTecnico,
        "descripcion": descripcion,
        "fecha_cita": fechaCita,
        // "${fechaCita.year.toString().padLeft(4, '0')}-${fechaCita.month.toString().padLeft(2, '0')}-${fechaCita.day.toString().padLeft(2, '0')}",
        "imagen": imagen,
        "comentario": comentario,
        "fecha_listo":
            "${fechaListo!.year.toString().padLeft(4, '0')}-${fechaListo!.month.toString().padLeft(2, '0')}-${fechaListo!.day.toString().padLeft(2, '0')}",
        "fecha_real":
            "${fechaReal!.year.toString().padLeft(4, '0')}-${fechaReal!.month.toString().padLeft(2, '0')}-${fechaReal!.day.toString().padLeft(2, '0')}",
        // "fecha_listo": fechaListo,
        // "fecha_real": fechaReal,
        "nombre": nombre,
        "estado": estado,
        "name": name,
        "last_name": lastName,
      };
}

class SolicitudesResponseUser {
  SolicitudesResponseUser({
    required this.idUser,
    required this.user,
  });

  String idUser;
  UserUser user;

  factory SolicitudesResponseUser.fromMap(Map<String, dynamic> json) =>
      SolicitudesResponseUser(
        idUser: json["id_user"],
        user: UserUser.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "user": user.toMap(),
      };
}

class UserUser {
  UserUser({
    required this.name,
    required this.lastName,
  });

  String name;
  String lastName;

  factory UserUser.fromMap(Map<String, dynamic> json) => UserUser(
        name: json["name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
      };
}
