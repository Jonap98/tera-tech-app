// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/solicitudes_model.dart';
import 'package:tera_tech_app/models/tecnicos_model.dart';
import 'package:tera_tech_app/providers/recursos_provider.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';
import 'package:tera_tech_app/services/local_storage.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';
import 'package:tera_tech_app/ui/layouts/auth/widgets/datetime_picker.dart';
import 'package:tera_tech_app/ui/layouts/auth/widgets/images.dart';

class TicketView extends StatelessWidget {
  const TicketView({Key? key}) : super(key: key);

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
    final idSolicitud =
        Provider.of<RecursosProvider>(context).obtenerIdSolicitud;
    final idEstado = Provider.of<RecursosProvider>(context).obtenerIdEstado;
    late Future<SolicitudesResponse> datos;
    datos = Provider.of<SolicitudesProvider>(context, listen: false)
        .getSolicitudesEstado(idSolicitud, idEstado);
    final idTecnico = Provider.of<RecursosProvider>(context).obtenerIdTecnico;

    final tecnico =
        Provider.of<RecursosProvider>(context).obtenerTecnicoSeleccionado;

    // late DatoTecnico tech;
    // final tecnico = Provider.of<RecursosProvider>(context)
    //     .getTecnicoPorId(idTecnico)
    //     .then((value) {
    //   Provider.of<RecursosProvider>(context).cargarTecnico(value[0]);
    // }).then((value) {
    //   tech = Provider.of<RecursosProvider>(context).obtenerTecnicoSeleccionado;
    // });

    TextEditingController fechaCierreCtrl = TextEditingController();

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
            ElevatedButton(
              child: Text('Prueba'),
              onPressed: () {
                print(_url);
                // final idSolicitud =
                //     Provider.of<RecursosProvider>(context).obtenerIdSolicitud;
                // final idEstado =
                //     Provider.of<RecursosProvider>(context).obtenerIdEstado;
                // final tecnico = Provider.of<RecursosProvider>(context)
                //     .obtenerTecnicoSeleccionado;
                print(idSolicitud);
                print(idEstado);
                print(tecnico.name);
              },
            ),
            const SizedBox(height: 10),
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
                                '${snapshot.data!.datos[0].nombreUsuario} ${snapshot.data!.datos[0].apellido}',
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
                                                _asignarTecnicoDialog(context);
                                              },
                                            ),
                                            SizedBox(width: 10),
                                            _CustomButton(
                                              text: 'Cerrar solicitud',
                                              color: Colors.redAccent,
                                              onPressed: () {
                                                _cerrarColicitudDialog(context);
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
                                                _cerrarColicitudDialog(context);
                                              },
                                            )
                                          : Container()
                                  : (idRol == 2)
                                      ? (snapshot.data!.datos[0].idEstado == 3)
                                          ? _CustomButton(
                                              text: 'Atender solicitud',
                                              color: Colors.blue,
                                              onPressed: () {
                                                _atenderColicitudDialog(
                                                    context, fechaCierreCtrl);
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
                                                        context);
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

  Future<dynamic> _atenderColicitudDialog(
      BuildContext context, TextEditingController fechaCierreCtrl) {
    return showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          content: Container(
            height: 450,
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
                CustomDateTimePicker(controller: fechaCierreCtrl),
                // selectDateTime(fechaCierreCtrl),
                const SizedBox(height: 15),
                _textFormField(),
                const SizedBox(height: 25),
                _CustomButton(
                  text: 'Aceptar',
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (builder) {
                        return AlertDialog(
                          content: Text(
                              'Atención de solicitud registrada exitosamente.'),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
// DateTimePicker selectDateTime(TextEditingController controller) {
  //   return DateTimePicker(
  //     type: DateTimePickerType.dateTimeSeparate,
  //     dateMask: 'd MMM, yyyy',
  //     initialValue: DateTime.now().toString(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //     icon: Icon(Icons.event),
  //     dateLabelText: 'Fecha',
  //     timeLabelText: 'Hora',
  //     selectableDayPredicate: (date) {
  //       // Deshabilita fines de semana
  //       // if (date.weekday == 6 ||
  //       //     date.weekday == 7) {
  //       //   return false;
  //       // }

  //       return true;
  //     },
  //     // onChanged: (val) => print(val),
  //     validator: (val) {
  //       // print(val);
  //       return null;
  //     },
  //     onSaved: (val) {
  //       controller.text = val!;
  //       // print(val);
  //     },
  //   );
  // }
  //

  TextFormField _textFormField() {
    return TextFormField(
      minLines: 1,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      maxLength: 500,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: const Color(0xffEDF1F2),
      ),
    );
  }

  Future<dynamic> _cerrarColicitudDialog(BuildContext context) {
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
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return AlertDialog(
                            content: Text('Solicitud cerrada exitosamente.'),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _asignarTecnicoDialog(BuildContext context) {
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
                _CustomDropDown(
                  titulo: 'Seleccionar técnico',
                ),
                const SizedBox(height: 25),
                _CustomButton(
                  text: 'Aceptar',
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (builder) {
                        return AlertDialog(
                          content: Text('Técnico asignado exitosamente.'),
                        );
                      },
                    );
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
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text('Detalle'),
      value: widget.valor,
      onChanged: (value) {
        setState(() {
          widget.valor = value!;
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

class _CustomDropDown extends StatefulWidget {
  final String titulo;

  const _CustomDropDown({
    Key? key,
    this.titulo = 'Seleccionar',
  }) : super(key: key);

  @override
  State<_CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<_CustomDropDown> {
  String? selectedValue;
  final opciones = [
    'Opción 1',
    'Opción 2',
    'Opción 3',
    'Opción 4',
    'Opción 5',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(widget.titulo),
      validator: (value) => value == null ? widget.titulo : null,
      value: selectedValue,
      // value: (dropdownValue != '') ? '' : 'Selecciona una categoría',
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: const Color(0xffEDF1F2),
      ),
      dropdownColor: const Color(0xffEDF1F2),
      icon: const Icon(Icons.arrow_drop_down),
      items: opciones.map((String opciones) {
        return DropdownMenuItem(
          value: opciones,
          child: Text(opciones),
        );
      }).toList(),
      onChanged: (String? newValue) {
        selectedValue = newValue!;
        setState(() {});
      },
    );
  }
}
