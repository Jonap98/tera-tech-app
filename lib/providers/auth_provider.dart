// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/auth_response.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/services/notification_service.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthProvider extends ChangeNotifier {
  // String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  CurrentUser? user;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    final data = {
      'email': email,
      'password': password,
    };

    CafeApi.httpPost('/login', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.data.currentUser;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setInt('id_usuario', authResponse.data.currentUser.id);
      LocalStorage.prefs.setString('token', authResponse.data.accessToken);
      LocalStorage.prefs.setString('name', authResponse.data.currentUser.name);
      LocalStorage.prefs
          .setString('lastName', authResponse.data.currentUser.lastName);
      LocalStorage.prefs.setInt('rol', authResponse.data.currentUser.idRol);
      // Guardar otros datos
      (authResponse.data.currentUser.idRol == 3)
          ? NavigationService.replaceTo(Flurorouter.dashboardRoute)
          : NavigationService.replaceTo(Flurorouter.estadosSoporteRoute);
      // NavigationService.replaceTo(Flurorouter.whiteRoute);

      CafeApi.configureDio();

      notifyListeners();
    }).catchError(
      (e) {
        NotificationService.showSnackbarError(
            'Favor de revisar sus credenciales.');
        // print('Error en $e');
        // Posible implementación de notificación de error
      },
    );
    // Petición http

    // Almacenar JWT en localStorage
    // _token = 'askdjaskñañadskddñ.askjñasldaaSÑakd.aiuscsmkjjasajhasksajdlj';
    // LocalStorage.prefs.setString('token', _token!);

    // // Cambia el estado, se verifica en el main y automáticamente determina
    // // el layout al que redirecciona
    // authStatus = AuthStatus.authenticated;
    // notifyListeners();
    // // Navegar al dashboard

    // // Esto solo cambia el URL
    // NavigationService.replaceTo(Flurorouter.dashboardRoute);
  }

  register(String name, String lastName, String email, String password) {
    final data = {
      'id_rol': 3,
      'name': name,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };

    CafeApi.httpPost('/registro', data).then((json) {
      // print(json);
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.data.currentUser;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setInt('id_usuario', authResponse.data.currentUser.id);
      LocalStorage.prefs.setString('token', authResponse.data.accessToken);
      LocalStorage.prefs.setString('name', authResponse.data.currentUser.name);
      LocalStorage.prefs
          .setString('lastName', authResponse.data.currentUser.lastName);
      LocalStorage.prefs.setInt('rol', authResponse.data.currentUser.idRol);
      // Guardar otros datos
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      // NavigationService.replaceTo(Flurorouter.whiteRoute);

      CafeApi.configureDio();

      notifyListeners();
    }).catchError(
      (e) {
        NotificationService.showSnackbarError(
            'Ya existe una cuenta registrada con ese email.');
        // print('Error en $e');
        // Posible implementación de notificación de error
      },
    );
  }

  registrarEmpleado(BuildContext context, String name, String lastName,
      String email, String password, int idRol, int idEspecialidad) {
    // final password =

    final data = {
      'id_rol': (idRol != -1) ? idRol : null,
      'id_especialidad': idEspecialidad,
      'name': name,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };

    CafeApi.httpPost('/registro-empleados', data).then((json) {
      // print(json);
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.data.currentUser;
      NotificationService.registroExitoso(
          context,
          'Empleado registrado exitosamente\nSe envió la contraseña a su correo',
          Flurorouter.estadosSoporteRoute);

      // authStatus = AuthStatus.authenticated;
      // LocalStorage.prefs.setInt('id_usuario', authResponse.data.currentUser.id);
      // LocalStorage.prefs.setString('token', authResponse.data.accessToken);
      // LocalStorage.prefs.setString('name', authResponse.data.currentUser.name);
      // LocalStorage.prefs
      //     .setString('lastName', authResponse.data.currentUser.lastName);
      // LocalStorage.prefs.setInt('rol', authResponse.data.currentUser.idRol);
      // Guardar otros datos
      // NavigationService.replaceTo(Flurorouter.estadosSoporteRoute);
      // NavigationService.replaceTo(Flurorouter.whiteRoute);

      CafeApi.configureDio();

      notifyListeners();
    }).catchError(
      (e) {
        NotificationService.showSnackbarError(
            'Ya existe una cuenta registrada con ese email.');
        // print('Error en $e');
        // Posible implementación de notificación de error
      },
    );
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();

      return false;
    }

    // Sesión activa durante token válido
    // Comprobar JWT válido
    // try {
    //   final resp = await CafeApi.httpGet('/auth');
    //   final authResponse = AuthResponse.fromMap(resp);

    //   user = authResponse.data.currentUser;
    //   authStatus = AuthStatus.authenticated;
    //   notifyListeners();
    //   return true;
    // } catch (e) {
    //   // print(e);
    //   authStatus = AuthStatus.notAuthenticated;
    //   notifyListeners();
    //   return false;
    // }

    // Sesión activa hasta logout manual, mediante token existente
    await Future.delayed(const Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();

    return true;
  }

  logout() {
    LocalStorage.prefs.remove('id_usuario');
    LocalStorage.prefs.remove('token');
    LocalStorage.prefs.remove('rol');
    LocalStorage.prefs.remove('name');
    LocalStorage.prefs.remove('lastName');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
    NavigationService.replaceTo(Flurorouter.loginRoute);
  }
}
