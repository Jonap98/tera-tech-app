// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
import 'package:tera_tech_app/services/navigation_service.dart';

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

    // Cambia el estado, se verifica en el main y automáticamente determina
    // el layout al que redirecciona
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    // Navegar al dashboard

    // Esto solo cambia el URL
    NavigationService.replaceTo(Flurorouter.dashboardRoute);
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
