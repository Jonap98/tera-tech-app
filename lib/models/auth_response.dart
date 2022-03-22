// To parse this JSON data, do
//
//     final authResponse = authResponseFromMap(jsonString);

import 'dart:convert';

AuthResponse authResponseFromMap(String str) =>
    AuthResponse.fromMap(json.decode(str));

String authResponseToMap(AuthResponse data) => json.encode(data.toMap());

class AuthResponse {
  AuthResponse({
    required this.result,
    required this.data,
    required this.message,
  });

  bool result;
  Data data;
  String message;

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
        result: json["result"],
        data: Data.fromMap(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "data": data.toMap(),
        "message": message,
      };
}

class Data {
  Data({
    required this.currentUser,
    required this.accessToken,
    required this.expiresIn,
  });

  CurrentUser currentUser;
  String accessToken;
  int expiresIn;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentUser: CurrentUser.fromMap(json["current_user"]),
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toMap() => {
        "current_user": currentUser.toMap(),
        "access_token": accessToken,
        "expires_in": expiresIn,
      };
}

class CurrentUser {
  CurrentUser({
    required this.id,
    required this.idRol,
    this.idEspecialidad,
    required this.name,
    required this.lastName,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int idRol;
  int? idEspecialidad;
  String name;
  String lastName;
  String email;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory CurrentUser.fromMap(Map<String, dynamic> json) => CurrentUser(
        id: json["id"],
        idRol: json["id_rol"],
        idEspecialidad: json["id_especialidad"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["created_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_rol": idRol,
        "id_especialidad": idEspecialidad,
        "name": name,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt!.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
