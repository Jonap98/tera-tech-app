// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/models/disponibilidad_citas.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';
import 'package:tera_tech_app/services/notification_service.dart';

class CustomDateTimePicker extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  String? title = 'Calendario';

  CustomDateTimePicker({
    Key? key,
    this.controller,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final solicitudesProvider = Provider.of<SolicitudesProvider>(context);
    late DisponibilidadCitas? disponibilidad;

    return DateTimePicker(
      initialTime: const TimeOfDay(hour: 10, minute: 00),
      initialDate: (DateTime.now().weekday == 7)
          ? DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
          : DateTime.now(),
      calendarTitle: title,
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMM, yyyy',
      initialValue: (DateTime.now().weekday == 7)
          ? DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day + 1)
              .toString()
          : DateTime.now().toString(),
      // firstDate: DateTime.now(),
      firstDate: (DateTime.now().weekday == 7)
          ? DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
          : DateTime.now(),
      lastDate: DateTime(2100),
      icon: const Icon(Icons.event),
      dateLabelText: 'Fecha',
      timeLabelText: 'Hora',
      onFieldSubmitted: (val) {
        // print('OnfFieldSubmitted: $val');
      },
      onEditingComplete: () {},
      // Deshabilita fines de semana
      selectableDayPredicate: (date) => (date.weekday == 7) ? false : true,
      // onChanged: (val) => print(val),
      onChanged: (val) async {
        // print(val.substring(0, 10));
        disponibilidad =
            await Provider.of<SolicitudesProvider>(context, listen: false)
                .verificarDisponibilidad(val.substring(0, 10))
                .then((value) {
          // Aquí es la carga de la fecha
          // print(val.substring(0, 10));
          // print('Citas registradas: ${value.solicitudesCount}');
          if (value.solicitudesCount >= 5) {
            solicitudesProvider.cargarDisponibilidad(false);
            NotificationService.genericDialog(context,
                'No hay citas disponibles para esta fecha:\n${val.substring(0, 10)}');
            // print('No hay citas disponibles para esta fecha');
          } else {
            solicitudesProvider.cargarDisponibilidad(true);
            solicitudesProvider.cargarFecha(val);
          }
        });
        // print('Citas registradas: ${disponibilidad!.solicitudesCount}');
      },
      validator: (val) {
        // print(val);
        return null;
      },
      onSaved: (val) {
        controller!.text = val!;
        // print(val);
        // Provider.of<SolicitudesProvider>(context, listen: false)
        //     .cargarFecha(val);
      },
    );
  }
}
