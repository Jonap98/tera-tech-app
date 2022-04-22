// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print, must_be_immutable

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/solicitudes_model.dart';
import 'package:tera_tech_app/models/tecnicos_model.dart';
import 'package:tera_tech_app/providers/recursos_provider.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
// import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/services/notification_service.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';
// import 'package:tera_tech_app/ui/layouts/auth/widgets/datetime_picker.dart';
import 'package:tera_tech_app/ui/layouts/auth/widgets/images.dart';
import 'package:tera_tech_app/ui/shared/widgets/dropdown_tecnicos.dart';

class TicketView extends StatefulWidget {
  const TicketView({Key? key}) : super(key: key);

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  late int idSolicitud;
  late int idEstado;
  late int idTecnico;
  late Future<SolicitudesResponse> datos;
  late DatoTecnico tecnico;
  late SolicitudesProvider solicitudesProvider;

  @override
  void initState() {
    super.initState();
    idSolicitud = Provider.of<RecursosProvider>(context, listen: false)
        .obtenerIdSolicitud;
    idEstado =
        Provider.of<RecursosProvider>(context, listen: false).obtenerIdEstado;
    datos = Provider.of<SolicitudesProvider>(context, listen: false)
        .getSolicitudesEstado(idSolicitud, idEstado);
    idTecnico =
        Provider.of<RecursosProvider>(context, listen: false).obtenerIdTecnico;

    tecnico = Provider.of<RecursosProvider>(context, listen: false)
        .obtenerTecnicoSeleccionado;

    solicitudesProvider =
        Provider.of<SolicitudesProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final idRol = LocalStorage.prefs.getInt('rol');
    // idRol == 1 - Admin
    // idRol == 2 - Técnico

    // late Future<SolicitudesResponse> datos;
    // datos = Provider.of<SolicitudesProvider>(context, listen: false)
    //     .getSolicitudes(idUser!);
    // final datos = Provider.of<SolicitudesProvider>(context, listen: false)
    //     .obtenerSolicitud;
    // Se debe realizar la consulta de la solicitud, ya que si solo se utilizan los datos
    // existentes, al regargar la página se perderán

    // Este se utilizará para realizar las acciones de cerrar y actualizar
    // ya se me había hecho mucho rollo con las anteriores, ya no tuve tiempo
    // De refatorizar eso
    // final solicitudesProvider = Provider.of<SolicitudesProvider>(context);

    // late DatoTecnico tech;
    // final tecnico = Provider.of<RecursosProvider>(context)
    //     .getTecnicoPorId(idTecnico)
    //     .then((value) {
    //   Provider.of<RecursosProvider>(context).cargarTecnico(value[0]);
    // }).then((value) {
    //   tech = Provider.of<RecursosProvider>(context).obtenerTecnicoSeleccionado;
    // });

    // const idRol = 1;
    // const tecnico = 'Juan Cerros';
    // final size = MediaQuery.of(context).size;
    final _url = CafeApi.getUrl();

    return SingleChildScrollView(
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
        width: double.infinity,
        // height: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                'Ticket',
                style: CustomLabels.h1,
              ),
            ),
            // ElevatedButton(
            //   child: Text('Prueba'),
            //   onPressed: () {
            //     print(_url);
            //     // final idSolicitud =
            //     //     Provider.of<RecursosProvider>(context).obtenerIdSolicitud;
            //     // final idEstado =
            //     //     Provider.of<RecursosProvider>(context).obtenerIdEstado;
            //     // final tecnico = Provider.of<RecursosProvider>(context)
            //     //     .obtenerTecnicoSeleccionado;
            //     print(idSolicitud);
            //     print(idEstado);
            //     print(tecnico.name);
            //   },
            // ),
            // const SizedBox(height: 10),
            FutureBuilder(
                future: datos,
                builder:
                    (context, AsyncSnapshot<SolicitudesResponse> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.datos.isNotEmpty) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text(
                                // 'Marijose Martinez',
                                '${snapshot.data!.datos[0].nombreUsuario} ${snapshot.data!.datos[0].apellidoUsuario}',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              // 'Formateo | 23/04/2022',
                              '${snapshot.data!.datos[0].nombreCategoria} | ${snapshot.data!.datos[0].fechaCita}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Ticket de soporte #${snapshot.data!.datos[0].id}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              (snapshot.data!.datos[0].idTecnico != null)
                                  ? 'Técnico asignado: ${tecnico.name} ${tecnico.lastName}'
                                  : 'Técnico no asignado',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Descripción',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${snapshot.data!.datos[0].descripcion}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            (snapshot.data!.datos[0].imagen != null)
                                ? Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          right: 10, top: 5, bottom: 5),
                                      height: 300,
                                      width: 500,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        // La implementación de esta widget se realizó ya que no era posible
                                        // insertar un NetworkImage con esa url, la alternativa era ejecutar la app y compilarla
                                        // con --web-render html, lo que se vuelve muy tedioso en pruebas, además de alterar algunos estilos
                                        // en los textos y otras propiedades
                                        child: MyImage(
                                            url:
                                                '$_url/img/${snapshot.data!.datos[0].imagen!}'),
                                      ),
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                        // color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                        // image: DecorationImage(
                                        //   fit: BoxFit.cover,
                                        //   image: NetworkImage(
                                        //       '$_url/img/${snapshot.data!.datos[0].imagen!}'),
                                        // ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: 10),
                            Center(
                              child: (idRol == 1)
                                  ? (snapshot.data!.datos[0].idEstado == 1 ||
                                          snapshot.data!.datos[0].idEstado == 2)
                                      ? Wrap(
                                          children: [
                                            _CustomButton(
                                              text: 'Asignar técnico',
                                              color: Color(0xff28A745),
                                              onPressed: () {
                                                _asignarTecnicoDialog(context,
                                                    snapshot.data!.datos[0].id);
                                              },
                                            ),
                                            SizedBox(width: 10),
                                            _CustomButton(
                                              text: 'Cerrar solicitud',
                                              color: Colors.redAccent,
                                              onPressed: () {
                                                _cerrarColicitudDialog(
                                                  context,
                                                  snapshot.data!.datos[0].id,
                                                  solicitudesProvider,
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      : (snapshot.data!.datos[0].idEstado ==
                                                  3 ||
                                              snapshot.data!.datos[0]
                                                      .idEstado ==
                                                  4)
                                          ? _CustomButton(
                                              text: 'Cerrar solicitud',
                                              color: Colors.redAccent,
                                              onPressed: () {
                                                _cerrarColicitudDialog(
                                                  context,
                                                  snapshot.data!.datos[0].id,
                                                  solicitudesProvider,
                                                );
                                              },
                                            )
                                          : Container()
                                  : (idRol == 2)
                                      ? (snapshot.data!.datos[0].idEstado == 3)
                                          ? _CustomButton(
                                              text: 'Atender solicitud',
                                              color: Colors.blue,
                                              onPressed: () {
                                                _atenderSolicitudDialog(context,
                                                    snapshot.data!.datos[0].id);
                                              },
                                            )
                                          : (snapshot.data!.datos[0].idEstado ==
                                                      4 ||
                                                  snapshot.data!.datos[0]
                                                          .idEstado ==
                                                      5)
                                              ? _CustomButton(
                                                  text: 'Cerrar solicitud',
                                                  color: Colors.redAccent,
                                                  onPressed: () {
                                                    _cerrarColicitudDialog(
                                                      context,
                                                      snapshot
                                                          .data!.datos[0].id,
                                                      solicitudesProvider,
                                                    );
                                                  },
                                                )
                                              : Container()
                                      : Container(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No hay datos por mostrar'),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _atenderSolicitudDialog(
      BuildContext context, int idSolicitud) {
    TextEditingController comentarioCtrl = TextEditingController();

    return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          content: Container(
            height: 475,
            width: 350,
            child: Column(
              children: [
                const Text(
                  'Atender solicitud',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 15),
                _CheckBoxDetalle(valor: false),
                // Container(
                //   width: double.infinity,
                //   child: Text('Detalle'),
                // ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  child: Text('Fecha de cierre programado:'),
                ),
                const SizedBox(height: 15),
                _CustomDateTimePicker(),
                // selectDateTime(fechaCierreCtrl),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  child: Text('Comentario:'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: comentarioCtrl,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  maxLength: 500,
                  // onChanged: (value) {
                  //   print(value);
                  // },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffEDF1F2), width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffEDF1F2), width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: const Color(0xffEDF1F2),
                  ),
                ),
                // _textFormField(),
                const SizedBox(height: 25),
                _CustomButton(
                  text: 'Aceptar',
                  color: Colors.blue,
                  onPressed: () {
                    final detalle =
                        Provider.of<SolicitudesProvider>(context, listen: false)
                            .obtenerDetalle;
                    final fecha =
                        Provider.of<SolicitudesProvider>(context, listen: false)
                            .obtenerFecha;
                    // Navigator.pop(context);
                    print('detalle: $detalle');
                    print('comentarioCtrl: ${comentarioCtrl.text}');
                    print('fechaCierre: $fecha');

                    // Future.delayed(Duration(milliseconds: 5000), () {
                    print('context: $context');
                    print('idSolicitud: $idSolicitud');
                    print('detalle: $detalle');
                    print('comentarioCtrl: ${comentarioCtrl.text}');
                    if (fecha.isEmpty) {
                      print(DateTime.now().toString().substring(0, 16));
                    } else {
                      print('fechaCierre: ${fecha.substring(0, 16)}');
                    }

                    // final solicitudAtendida =
                    solicitudesProvider.atenderSolicitud(
                      context,
                      idSolicitud,
                      detalle,
                      comentarioCtrl.text,
                      (fecha.isNotEmpty)
                          ? fecha.substring(0, 16)
                          : DateTime.now().toString().substring(0, 16),
                    );
                    // if (solicitudAtendida) {
                    //   final det = Provider.of<SolicitudesProvider>(context,
                    //           listen: false)
                    //       .inicializarDetalle();
                    //   print('Detalle final: $det');
                    //   NotificationService.solicitudExitosa(
                    //       context,
                    //       'Solicitud atendida exitosamente',
                    //       Flurorouter.estadosSoporteRoute);
                    //   // NavigationService.navigateTo(
                    //   //     Flurorouter.estadosSoporteRoute);
                    // }

                    // });

                    // Fecha con ctrl no sirve
                    // print('fechaCierreCtrl: ${fechaCierreCtrl.text}');
                    // showDialog(
                    //   context: context,
                    //   builder: (builder) {
                    //     return AlertDialog(
                    //       content: Text(
                    //           'Atención de solicitud registrada exitosamente.'),
                    //     );
                    //   },
                    // );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _cerrarColicitudDialog(
    BuildContext context,
    int idSolicitud,
    SolicitudesProvider solicitudesProvider,
  ) {
    return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          content: Container(
            height: 200,
            width: 300,
            child: Column(
              children: [
                const Text(
                  '¿Seguro que desea cerrar la solicitud?',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 50),
                _CustomButton(
                  text: 'Cerrar solicitud',
                  color: Colors.blue,
                  onPressed: () {
                    // Navigator.pop(context);

                    print(idSolicitud);
                    final solicitudCerrada = solicitudesProvider
                        .cerrarSolicitud(context, idSolicitud);
                    if (solicitudCerrada) {
                      NotificationService.solicitudExitosa(
                          context,
                          'Solicitud cerrada exitosamente',
                          Flurorouter.estadosSoporteRoute);
                      // NavigationService.navigateTo(
                      //     Flurorouter.estadosSoporteRoute);
                    }

                    // showDialog(
                    //     context: context,
                    //     builder: (builder) {
                    //       return AlertDialog(
                    //         content: Text('Solicitud cerrada exitosamente.'),
                    //       );
                    //     });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _asignarTecnicoDialog(BuildContext context, int idSolicitud) {
    return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          content: Container(
            height: 200,
            width: 300,
            child: Column(
              children: [
                const Text(
                  'Asignar técnico',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 15),
                DropdownTecnicos(),
                const SizedBox(height: 25),
                _CustomButton(
                  text: 'Aceptar',
                  color: Colors.blue,
                  onPressed: () {
                    final tecnico =
                        Provider.of<RecursosProvider>(context, listen: false)
                            .obtenerTecnicoSeleccionado;

                    solicitudesProvider.asignarTecnico(
                        context, idSolicitud, tecnico.id);
                    // Navigator.pop(context);
                    // showDialog(
                    //   context: context,
                    //   builder: (builder) {
                    //     return AlertDialog(
                    //       content: Text('Técnico asignado exitosamente.'),
                    //     );
                    //   },
                    // );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CheckBoxDetalle extends StatefulWidget {
  bool valor;

  _CheckBoxDetalle({
    required this.valor,
    Key? key,
  }) : super(key: key);

  @override
  State<_CheckBoxDetalle> createState() => _CheckBoxDetalleState();
}

class _CheckBoxDetalleState extends State<_CheckBoxDetalle> {
  @override
  void initState() {
    super.initState();
    // Provider.of<SolicitudesProvider>(context, listen: false)
    //                     .inicializarDetalle();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text('Detalle'),
      value: widget.valor,
      onChanged: (value) {
        setState(() {
          widget.valor = value!;
          Provider.of<SolicitudesProvider>(context, listen: false)
              .cargarDetalle(widget.valor);
        });
      },
    );
  }
}

class _CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressed;

  const _CustomButton({
    Key? key,
    required this.color,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: color,
          // shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Container(
          width: 200,
          alignment: Alignment.center,
          // padding: const EdgeInsets.symmetric(vertical: 5),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            text,
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}

class _CustomDateTimePicker extends StatelessWidget {
  // TextEditingController? controller = TextEditingController();
  String? title = 'Calendario';

  _CustomDateTimePicker({
    Key? key,
    // this.controller,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final solicitudesProvider = Provider.of<SolicitudesProvider>(context);
    // late DisponibilidadCitas? disponibilidad;

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
        solicitudesProvider.cargarFecha(val);
      },
      //   print(val);
      //   solicitudesProvider.cargarFecha(val);
      //   // print(val.substring(0, 10));
      //   // disponibilidad =
      //   //     await Provider.of<SolicitudesProvider>(context, listen: false)
      //   //         .verificarDisponibilidad(val.substring(0, 10))
      //   //         .then((value) {
      //   //   // Aquí es la carga de la fecha
      //   //   // print(val.substring(0, 10));
      //   //   // print('Citas registradas: ${value.solicitudesCount}');
      //   //   if (value.solicitudesCount >= 5) {
      //   //     solicitudesProvider.cargarDisponibilidad(false);
      //   //     NotificationService.genericDialog(context,
      //   //         'No hay citas disponibles para esta fecha:\n${val.substring(0, 10)}');
      //   //     // print('No hay citas disponibles para esta fecha');
      //   //   } else {
      //   //     solicitudesProvider.cargarDisponibilidad(true);
      //   //   }
      //   // });
      //   // print('Citas registradas: ${disponibilidad!.solicitudesCount}');
      // },
      validator: (val) {
        // print(val);
        return null;
      },
      onSaved: (val) {
        // controller!.text = val!;
        // print(val);
        // Provider.of<SolicitudesProvider>(context, listen: false)
        //     .cargarFecha(val!);
      },
    );
  }
}
