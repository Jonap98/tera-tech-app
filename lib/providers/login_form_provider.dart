// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }
}

// Otra forma de hacerlo sería la siguiente:
// Inyección de dependencia, puede hacerse de esa manera, pero no es necesario
// import 'package:tera_tech_app/providers/auth_provider.dart';
// final AuthProvider authProvider;
// LoginFormProvider(this.authProvider);
// Este se llamaría al momento de que la validación fuera correcta
// authProvider.login(email, password);
// en su momento, mandamos un bool si es válido o no
