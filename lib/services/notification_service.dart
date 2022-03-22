import 'package:flutter/material.dart';

// El uso de un global Key permite el acceso al context, en este caso para poder
// hacer uso del snackbar desde fuera, aquí no tenemos acceso al context,
// este messengerKey es utilizado en el main por el scaffoldMessengerKey, de esa
// manera lo tenemos presente a lo largo de toda la app, de manera similar al
// navigatorKey

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbarError(String message) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 2500),
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
