// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/models/estados_model.dart';
import 'package:tera_tech_app/models/solicitudes_model.dart';
import 'package:tera_tech_app/providers/recursos_provider.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
// import 'package:tera_tech_app/ui/buttons/boton_azul.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';

class SoporteEstadoView extends StatefulWidget {
  const SoporteEstadoView({Key? key}) : super(key: key);

  @override
  State<SoporteEstadoView> createState() => _SoporteEstadoViewState();
}

class _SoporteEstadoViewState extends State<SoporteEstadoView> {
  late Estado estado;
  // late int? idUser;
  // late int? idRol;
  // late Future<SolicitudesResponse> datos;

  @override
  void initState() {
    super.initState();
    estado =
        Provider.of<RecursosProvider>(context, listen: false).obtenerEstado;

    //   idUser = LocalStorage.prefs.getInt('id_usuario');
    //   idRol = LocalStorage.prefs.getInt('rol');
    //   // datos = Provider.of<SolicitudesProvider>(context, listen: false)
    //   //     .getSolicitudes(idUser!);
    //   if (idRol == 1) {
    //     datos = Provider.of<SolicitudesProvider>(context, listen: false)
    //         .getSolicitudesEstado(null, estado.id);
    //   } else if (idRol == 2) {
    //     datos = Provider.of<SolicitudesProvider>(context, listen: false)
    //         .getSolicitudesEstadoTecnico(null, estado.id, idUser!);
    //   }
  }

  @override
  Widget build(BuildContext context) {
    final idUser = LocalStorage.prefs.getInt('id_usuario');
    late Future<SolicitudesResponse> datos;
    final idRol = LocalStorage.prefs.getInt('rol');
    // datos = Provider.of<SolicitudesProvider>(context, listen: false)
    //     .getSolicitudes(idUser!);
    if (idRol == 1) {
      datos = Provider.of<SolicitudesProvider>(context, listen: false)
          .getSolicitudesEstado(null, estado.id);
    } else if (idRol == 2) {
      datos = Provider.of<SolicitudesProvider>(context, listen: false)
          .getSolicitudesEstadoTecnico(null, estado.id, idUser!);
    }

    return Container(
      margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            estado.nombre,
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 20),
          Expanded(
            // padding: const EdgeInsets.all(value),s
            child: FutureBuilder(
              future: datos,
              builder: (BuildContext context,
                  AsyncSnapshot<SolicitudesResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.datos.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.solicitudesCount,
                      itemBuilder: (context, index) {
                        // return Column(
                        //   children: [
                        //     Container(
                        //       color: Colors.redAccent,
                        //       height: 10,
                        //       width: 20,
                        //     ),
                        //   ],
                        // );
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
                                  // margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      // const Icon(Icons.home_repair_service,
                                      //     size: 40, color: Colors.blue),
                                      // (solicitudes[index]['id_categoria'] == 1)
                                      (snapshot.data!.datos[index]
                                                  .idCategoria ==
                                              1)
                                          ? const Icon(
                                              Icons.home_repair_service,
                                              size: 40,
                                              color: Colors.blue)
                                          : (snapshot.data!.datos[index]
                                                      .idCategoria ==
                                                  2)
                                              ? const Icon(Icons.update,
                                                  size: 40, color: Colors.blue)
                                              : (snapshot.data!.datos[index]
                                                          .idCategoria ==
                                                      3)
                                                  ? const Icon(
                                                      Icons.downloading,
                                                      size: 40,
                                                      color: Colors.blue)
                                                  : (snapshot.data!.datos[index]
                                                              .idCategoria ==
                                                          4)
                                                      ? const Icon(
                                                          Icons.handyman,
                                                          size: 40,
                                                          color: Colors.blue)
                                                      : (snapshot
                                                                  .data!
                                                                  .datos[index]
                                                                  .idCategoria ==
                                                              5)
                                                          ? const Icon(
                                                              Icons.report,
                                                              size: 40,
                                                              color:
                                                                  Colors.blue)
                                                          : const Icon(
                                                              Icons.more_horiz,
                                                              size: 40,
                                                              color:
                                                                  Colors.blue),
                                      const SizedBox(width: 20),
                                      Container(
                                          height: 30,
                                          width: 2,
                                          color: Colors.black),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // '${solicitudes[index]['nombre']}',
                                            snapshot.data!.datos[index]
                                                .nombreCategoria,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Text('${solicitudes[index]['fecha']}'),
                                          Text(snapshot
                                              .data!.datos[index].fechaCita),
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
                        // return _SoportePorEstado(
                        //     // onPressed: () => print('Click'),
                        //     // onPressed: NavigationService.navigateTo(
                        //     //     Flurorouter.ticketDeSolicitudRoute),
                        //     index: index,
                        //     solicitudes: snapshot.data!);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No hay solicitudes por mostrar'),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            // child: ListView.builder(
            //   itemCount: solicitudes.length,
            //   itemBuilder: (context, index) {
            //     return _SoportePorEstado(
            //         // onPressed: () => print('Click'),
            //         // onPressed: NavigationService.navigateTo(
            //         //     Flurorouter.ticketDeSolicitudRoute),
            //         index: index,
            //         solicitudes: solicitudes);
            //   },
            // ),
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

  // final List<Map<String, Object>> solicitudes;
  final SolicitudesResponse solicitudes;

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
                  // (solicitudes[index]['id_categoria'] == 1)
                  (solicitudes.datos[index].idCategoria == 1)
                      ? const Icon(Icons.home_repair_service,
                          size: 40, color: Colors.blue)
                      : (solicitudes.datos[index].idCategoria == 2)
                          ? const Icon(Icons.update,
                              size: 40, color: Colors.blue)
                          : (solicitudes.datos[index].idCategoria == 3)
                              ? const Icon(Icons.downloading,
                                  size: 40, color: Colors.blue)
                              : (solicitudes.datos[index].idCategoria == 4)
                                  ? const Icon(Icons.handyman,
                                      size: 40, color: Colors.blue)
                                  : (solicitudes.datos[index].idCategoria == 5)
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
                        // '${solicitudes[index]['nombre']}',
                        solicitudes.datos[index].nombreCategoria,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Text('${solicitudes[index]['fecha']}'),
                      Text(solicitudes.datos[index].fechaCita),
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
