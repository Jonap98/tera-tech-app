// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/models/solicitudes_model.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';
// import 'package:tera_tech_app/ui/buttons/boton_azul.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final idUser = LocalStorage.prefs.getInt('id_usuario');
    late Future<SolicitudesResponse> datos;
    datos = Provider.of<SolicitudesProvider>(context, listen: false)
        .getSolicitudesUsuario(idUser!);

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
            child: FutureBuilder(
              future: datos,
              builder: (BuildContext context,
                  AsyncSnapshot<SolicitudesResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.datos.isNotEmpty) {
                    return ListView.builder(
                      physics: ClampingScrollPhysics(), // Evita que rebote
                      // itemCount: solicitudes.length,
                      itemCount: snapshot.data!.solicitudesCount,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.datos[index]
                                            .nombreCategoria!,
                                        // '${solicitudes[index]['nombre']}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        snapshot.data!.datos[index].fechaCita,
                                        // '${snapshot.data!.datos[index].fechaCita.day}/${snapshot.data!.datos[index].fechaCita.month}/${snapshot.data!.datos[index].fechaCita.year} - ${snapshot.data!.datos[index].estado}',
                                        // '${solicitudes[index]['fecha']} - ${solicitudes[index]['estado']}',
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
                    );
                  } else {
                    return Center(
                        child: Text('No hay solicitudes para mostrar'));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ))
          // child: ListView.builder(
          //   itemCount: 1,
          //   itemBuilder: (context, itemCount) {
          //     return Container(
          //       color: Colors.redAccent,
          //       width: double.infinity,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
