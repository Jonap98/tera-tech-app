// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tera_tech_app/router/router.dart';

import 'navigation_service.dart';

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

  static showBusyIndicator(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
        content: Container(
      width: 100,
      height: 100,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ));

    showDialog(context: context, builder: (_) => dialog);
  }

  static solicitudExitosa(BuildContext context, mensaje) {
    final AlertDialog dialog = AlertDialog(
      content: Container(
        height: 80,
        child: Column(
          children: [
            Text(
              mensaje,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  NavigationService.navigateTo(Flurorouter.whiteRoute),
              child: const Text('Aceptar'),
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context, barrierDismissible: false, builder: (_) => dialog);
  }
}
