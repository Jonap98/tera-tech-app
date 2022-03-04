// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';
// import 'package:tera_tech_app/ui/buttons/boton_azul.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    final solicitudes = [
      {
        'nombre': 'Pantalla Quebrada',
        'fecha': '02/03/2022',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Formateo',
        'fecha': '02/13/2022',
        'estado': 'Abierto',
      },
      {
        'nombre': 'Cambiar teclado',
        'fecha': '05/10/2022',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Pantalla Quebrada',
        'fecha': '02/03/2022',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Formateo',
        'fecha': '02/13/2022',
        'estado': 'Abierto',
      },
      {
        'nombre': 'Cambiar teclado',
        'fecha': '05/10/2022',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Pantalla Quebrada',
        'fecha': '02/03/2022',
        'estado': 'Sin asignar',
      },
      {
        'nombre': 'Formateo',
        'fecha': '02/13/2022',
        'estado': 'Abierto',
      },
      {
        'nombre': 'Cambiar teclado',
        'fecha': '05/10/2022',
        'estado': 'Sin asignar',
      }
    ];

    return Container(
      margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
      width: double.infinity,
      height: double.infinity,
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Mis solicitudes',
                style: CustomLabels.h1,
                // TextStyle(
                //   fontSize: 25,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                    context, Flurorouter.solicitarSoporteRoute),
                child: Text('Solicitar soporte'),
              ),
              // CustomElevatedButton(text: 'Solicitar soporte'),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
              // width: size.width,
              // height: size.height,
              child: Container(
            // color: Colors.redAccent,
            child: ListView.builder(
              physics: ClampingScrollPhysics(), // Evita que rebote
              itemCount: solicitudes.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => print('Click'),
                        child: Container(
                          // margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(20),
                          // color: Colors.redAccent,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${solicitudes[index]['nombre']}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${solicitudes[index]['fecha']} - ${solicitudes[index]['estado']}',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              // Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
          )
              // child: ListView.builder(
              //   itemCount: 1,
              //   itemBuilder: (context, itemCount) {
              //     return Container(
              //       color: Colors.redAccent,
              //       width: double.infinity,
              //     );
              //   },
              // ),
              ),
        ],
      ),
    );
  }
}
