// To parse this JSON data, do
//
//     final disponibilidadCitas = disponibilidadCitasFromMap(jsonString);

import 'dart:convert';

DisponibilidadCitas disponibilidadCitasFromMap(String str) =>
    DisponibilidadCitas.fromMap(json.decode(str));

String disponibilidadCitasToMap(DisponibilidadCitas data) =>
    json.encode(data.toMap());

class DisponibilidadCitas {
  DisponibilidadCitas({
    required this.result,
    required this.solicitudesCount,
    required this.solicitud,
  });

  bool result;
  int solicitudesCount;
  List<Solicitud> solicitud;

  factory DisponibilidadCitas.fromMap(Map<String, dynamic> json) =>
      DisponibilidadCitas(
        result: json["result"],
        solicitudesCount: json["solicitudes_count"],
        solicitud: List<Solicitud>.from(
            json["solicitud"].map((x) => Solicitud.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "solicitudes_count": solicitudesCount,
        "solicitud": List<dynamic>.from(solicitud.map((x) => x.toMap())),
      };
}

class Solicitud {
  Solicitud({
    required this.id,
  });

  int id;

  factory Solicitud.fromMap(Map<String, dynamic> json) => Solicitud(
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
