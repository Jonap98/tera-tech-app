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
    this.user,
    required this.datos,
  });

  bool result;
  int solicitudesCount;
  SolicitudesResponseUser? user;
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
        "user": user!.toMap(),
        "datos": List<dynamic>.from(datos.map((x) => x.toMap())),
      };
}

class Dato {
  Dato({
    required this.id,
    required this.idUsuario,
    required this.idCategoria,
    required this.idEstado,
    this.idTecnico,
    this.descripcion,
    required this.fechaCita,
    this.imagen,
    this.comentario,
    this.fechaListo,
    this.fechaReal,
    this.nombreCategoria,
    this.nombreEstado,
    this.nombreUsuario,
    this.apellidoUsuario,
    this.nombreTecnico,
    this.apellidoTecnico,
  });

  int id;
  int idUsuario;
  int idCategoria;
  int idEstado;
  int? idTecnico;
  String? descripcion;
  String fechaCita;
  String? imagen;
  String? comentario;
  String? fechaListo;
  String? fechaReal;
  String? nombreCategoria;
  String? nombreEstado;
  String? nombreUsuario;
  String? apellidoUsuario;
  String? nombreTecnico;
  String? apellidoTecnico;

  factory Dato.fromMap(Map<String, dynamic> json) => Dato(
        id: json["id"],
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
        nombreCategoria: json["nombre_categoria"],
        nombreEstado: json["nombre_estado"],
        nombreUsuario: json["nombre_usuario"],
        apellidoUsuario: json["apellido_usuario"],
        nombreTecnico: json["nombre_tecnico"],
        apellidoTecnico: json["apellido_tecnico"],
      );

  // Formato de fechas generados por Quicktype
  Map<String, dynamic> toMap() => {
        "id": id,
        "id_usuario": idUsuario,
        "id_categoria": idCategoria,
        "id_estado": idEstado,
        "id_tecnico": idTecnico,
        "descripcion": descripcion,
        "fecha_cita": fechaCita,
        // "${fechaCita.year.toString().padLeft(4, '0')}-${fechaCita.month.toString().padLeft(2, '0')}-${fechaCita.day.toString().padLeft(2, '0')}",
        "imagen": imagen,
        "comentario": comentario,
        "fecha_listo": fechaListo,
        // "${fechaListo!.year.toString().padLeft(4, '0')}-${fechaListo!.month.toString().padLeft(2, '0')}-${fechaListo!.day.toString().padLeft(2, '0')}",
        "fecha_real": fechaReal,
        // "${fechaReal!.year.toString().padLeft(4, '0')}-${fechaReal!.month.toString().padLeft(2, '0')}-${fechaReal!.day.toString().padLeft(2, '0')}",
        // "fecha_listo": fechaListo,
        // "fecha_real": fechaReal,
        "nombre_categoria": nombreCategoria,
        "nombre_estado": nombreEstado,
        "nombre_usuario": nombreUsuario,
        "apellido_usuario": apellidoUsuario,
        "nombre_tecnico": nombreTecnico,
        "apellido_tecnico": apellidoTecnico,
      };
}

class SolicitudesResponseUser {
  SolicitudesResponseUser({
    this.idUser,
    this.user,
  });

  String? idUser;
  UserUser? user;

  factory SolicitudesResponseUser.fromMap(Map<String, dynamic> json) =>
      SolicitudesResponseUser(
        idUser: json["id_user"],
        user: UserUser.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "user": user!.toMap(),
      };
}

class UserUser {
  UserUser({
    this.name,
    this.lastName,
  });

  String? name;
  String? lastName;

  factory UserUser.fromMap(Map<String, dynamic> json) => UserUser(
        name: json["name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
      };
}
