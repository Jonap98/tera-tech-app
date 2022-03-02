// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tera_tech_app/services/local_storage.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    // Petición http

    // Almacenar JWT en localStorage
    _token = 'askdjaskñañadskddñ.askjñasldaaSÑakd.aiuscsmkjjasajhasksajdlj';
    LocalStorage.prefs.setString('token', _token!);

    // Navegar al dashboard

    notifyListeners();
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();

      return false;
    }

    // Comprobar JWT válido
    await Future.delayed(const Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();

    return true;
  }
}
