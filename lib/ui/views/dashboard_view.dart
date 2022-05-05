// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/models/solicitudes_model.dart';
import 'package:tera_tech_app/providers/recursos_provider.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
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
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: datos,
                builder: (BuildContext context,
                    AsyncSnapshot<SolicitudesResponse> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.datos.isNotEmpty) {
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data!.solicitudesCount,
                        itemBuilder: (context, index) {
                          final day = snapshot.data!.datos[index].fechaCita
                              .substring(8, 10);
                          final month = snapshot.data!.datos[index].fechaCita
                              .substring(5, 7);
                          final year = snapshot.data!.datos[index].fechaCita
                              .substring(0, 4);
                          return Column(
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    // Provider.of<SolicitudesProvider>(context,
                                    //         listen: false)
                                    //     .cargarSolicitud(
                                    //         snapshot.data!.datos[index]);
                                    Provider.of<RecursosProvider>(context,
                                            listen: false)
                                        .cargarIdsSolicitud(
                                      snapshot.data!.datos[index].id,
                                      snapshot.data!.datos[index].idEstado,
                                      // snapshot.data!.datos[index].idTecnico!,
                                    );

                                    // Provider.of<RecursosProvider>(context,
                                    //         listen: false)
                                    //     .getTecnicoPorId(
                                    //         datos.idTecnico!, datos.idEstado);
                                    if (snapshot.data!.datos[index].idTecnico !=
                                        null) {
                                      Provider.of<RecursosProvider>(context,
                                              listen: false)
                                          .getTecnicoPorId(snapshot
                                              .data!.datos[index].idTecnico!);
                                      print(
                                          'Técnico seleccionado: ${snapshot.data!.datos[index].idTecnico}');
                                    }
                                    NavigationService.navigateTo(
                                        Flurorouter.ticketDeSolicitudRoute);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
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
                                        Wrap(
                                          children: [
                                            Text(
                                              snapshot.data!.datos[index]
                                                  .nombreCategoria!,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            (snapshot.data!.datos[index]
                                                        .comentarioSolucion !=
                                                    null)
                                                ? Container(
                                                    width: 500,
                                                    child: Text(
                                                      snapshot
                                                          .data!
                                                          .datos[index]
                                                          .comentarioSolucion!,
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Wrap(
                                          children: [
                                            Text(
                                              'Fecha cita: $day/$month/$year',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            (snapshot.data!.datos[index]
                                                        .fechaListo !=
                                                    null)
                                                ? Text(
                                                    ' | Fecha entrega: ${snapshot.data!.datos[index].fechaListo}',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  )
                                                : Text(
                                                    ' | Fecha de entrega: PTE',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                            (snapshot.data!.datos[index]
                                                        .idEstado ==
                                                    6)
                                                ? Text(
                                                    ' | Estatus: ${snapshot.data!.datos[index].nombreEstado} - Favor de pasar a recojer',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  )
                                                : Container(),
                                          ],
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
            ),
          )
        ],
      ),
    );
  }
}
