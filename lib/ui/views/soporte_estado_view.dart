// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
// import 'package:tera_tech_app/ui/buttons/boton_azul.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';

class SoporteEstadoView extends StatelessWidget {
  const SoporteEstadoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final solicitudes = [
      {
        'nombre': 'Pantalla Quebrada',
        'fecha': '02/03/2022',
        'id_categoria': 1,
        'categoria': 'Mantenimiento general',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Formateo',
        'fecha': '02/13/2022',
        'id_categoria': 2,
        'categoria': 'Formateo',
        'estado': 'Abierto',
      },
      {
        'nombre': 'Cambiar teclado',
        'fecha': '05/10/2022',
        'id_categoria': 3,
        'categoria': 'Instalar programas',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Pantalla Quebrada',
        'fecha': '02/03/2022',
        'id_categoria': 4,
        'categoria': 'Cambiar piezas',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Formateo',
        'fecha': '02/13/2022',
        'id_categoria': 5,
        'categoria': 'Reparación',
        'estado': 'Abierto',
      },
      {
        'nombre': 'Cambiar teclado',
        'fecha': '05/10/2022',
        'id_categoria': 6,
        'categoria': 'Otra',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Pantalla Quebrada',
        'fecha': '02/03/2022',
        'id_categoria': 2,
        'categoria': 'Formateo',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Formateo',
        'fecha': '02/13/2022',
        'id_categoria': 3,
        'categoria': 'Instalar programas',
        'estado': 'Abierto',
      },
      {
        'nombre': 'Cambiar teclado',
        'fecha': '05/10/2022',
        'id_categoria': 2,
        'categoria': 'Formateo',
        'estado': 'Sin asignar',
      }
    ];

    return Container(
      margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sin asignar',
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 20),
          Expanded(
            // padding: const EdgeInsets.all(value),s
            child: ListView.builder(
              itemCount: solicitudes.length,
              itemBuilder: (context, index) {
                return _SoportePorEstado(
                    // onPressed: () => print('Click'),
                    // onPressed: NavigationService.navigateTo(
                    //     Flurorouter.ticketDeSolicitudRoute),
                    index: index,
                    solicitudes: solicitudes);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _SoportePorEstado extends StatelessWidget {
  int index;
  // final VoidCallback? onPressed;

  _SoportePorEstado({
    Key? key,
    required this.index,
    // required this.onPressed,
    required this.solicitudes,
  }) : super(key: key);

  final List<Map<String, Object>> solicitudes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => NavigationService.navigateTo(
                Flurorouter.ticketDeSolicitudRoute),
            child: Container(
              // margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  (solicitudes[index]['id_categoria'] == 1)
                      ? const Icon(Icons.home_repair_service,
                          size: 40, color: Colors.blue)
                      : (solicitudes[index]['id_categoria'] == 2)
                          ? const Icon(Icons.update,
                              size: 40, color: Colors.blue)
                          : (solicitudes[index]['id_categoria'] == 3)
                              ? const Icon(Icons.downloading,
                                  size: 40, color: Colors.blue)
                              : (solicitudes[index]['id_categoria'] == 4)
                                  ? const Icon(Icons.handyman,
                                      size: 40, color: Colors.blue)
                                  : (solicitudes[index]['id_categoria'] == 5)
                                      ? const Icon(Icons.report,
                                          size: 40, color: Colors.blue)
                                      : const Icon(Icons.more_horiz,
                                          size: 40, color: Colors.blue),
                  const SizedBox(width: 20),
                  Container(height: 30, width: 2, color: Colors.black),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${solicitudes[index]['nombre']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${solicitudes[index]['fecha']}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
