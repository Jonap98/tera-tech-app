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
    this.fecha,
    required this.disponibles,
  });

  bool result;
  String? fecha;
  Disponibles disponibles;

  factory DisponibilidadCitas.fromMap(Map<String, dynamic> json) =>
      DisponibilidadCitas(
        result: json["result"],
        fecha: json["fecha"],
        disponibles: Disponibles.fromMap(json["disponibles"]),
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "fecha": fecha,
        "disponibles": disponibles.toMap(),
      };
}

class Disponibles {
  Disponibles({
    this.h11,
    this.h12,
    this.h13,
    this.h15,
    this.h16,
    this.h17,
  });

  bool? h11;
  bool? h12;
  bool? h13;
  bool? h15;
  bool? h16;
  bool? h17;

  factory Disponibles.fromMap(Map<String, dynamic> json) => Disponibles(
        h11: json["h11"],
        h12: json["h12"],
        h13: json["h13"],
        h15: json["h15"],
        h16: json["h16"],
        h17: json["h17"],
      );

  Map<String, dynamic> toMap() => {
        "h11": h11,
        "h12": h12,
        "h13": h13,
        "h15": h15,
        "h16": h16,
        "h17": h17,
      };
}

// Este es el modelo original, por lo pronto se quedará hasta que sea un hecho
// que ya no se usará
// // To parse this JSON data, do
// //
// //     final disponibilidadCitas = disponibilidadCitasFromMap(jsonString);

// import 'dart:convert';

// DisponibilidadCitas disponibilidadCitasFromMap(String str) =>
//     DisponibilidadCitas.fromMap(json.decode(str));

// String disponibilidadCitasToMap(DisponibilidadCitas data) =>
//     json.encode(data.toMap());

// class DisponibilidadCitas {
//   DisponibilidadCitas({
//     required this.result,
//     required this.solicitudesCount,
//     required this.solicitud,
//   });

//   bool result;
//   int solicitudesCount;
//   List<Solicitud> solicitud;

//   factory DisponibilidadCitas.fromMap(Map<String, dynamic> json) =>
//       DisponibilidadCitas(
//         result: json["result"],
//         solicitudesCount: json["solicitudes_count"],
//         solicitud: List<Solicitud>.from(
//             json["solicitud"].map((x) => Solicitud.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "result": result,
//         "solicitudes_count": solicitudesCount,
//         "solicitud": List<dynamic>.from(solicitud.map((x) => x.toMap())),
//       };
// }

// class Solicitud {
//   Solicitud({
//     required this.id,
//     this.fechaCita,
//   });

//   int id;
//   String? fechaCita;

//   factory Solicitud.fromMap(Map<String, dynamic> json) => Solicitud(
//         id: json["id"],
//         fechaCita: json["fecha_cita"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "fecha_cita": fechaCita,
//       };
// }
