// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String lastName = '';
  String email = '';
  String password = '';
  String passwordConfirmation = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      print('$name\n$lastName\n$email\n$password\n$passwordConfirmation');
      print('Valid form');
    } else {
      print('Not valid');
    }
  }
}
