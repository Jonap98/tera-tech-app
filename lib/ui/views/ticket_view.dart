// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';
import 'package:tera_tech_app/ui/layouts/auth/widgets/datetime_picker.dart';

class TicketView extends StatelessWidget {
  const TicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController fechaCierreCtrl = TextEditingController();

    const idRol = 1;
    const tecnico = 'Juan Cerros';
    // final size = MediaQuery.of(context).size;

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
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
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
                      'Marijose Martinez',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Formateo | 23/04/2022',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ticket de soporte #566239',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    (tecnico != '')
                        ? 'Técnico asignado: $tecnico'
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
                    'Dolore proident duis incididunt aute cillum eiusmod exercitation eu ea. Voluptate nostrud cupidatat laborum anim voluptate consequat. Ex dolor pariatur laborum laboris do. Exercitation nisi qui id labore mollit proident minim adipisicing. Ipsum consectetur voluptate voluptate voluptate do minim occaecat quis in consectetur eu. Non duis amet cillum irure anim incididunt exercitation voluptate aliqua officia eu cillum. ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 300,
                    width: double.infinity,
                    // color: Colors.redAccent,
                    // padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          // padding: const EdgeInsets.symmetric(vertical: 15),
                          margin: const EdgeInsets.only(
                              right: 10, top: 5, bottom: 5),
                          height: 300,
                          width: 300,
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
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/engineer.png'),
                              )),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  (idRol != 1)
                      ? Center(
                          child: Wrap(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              (tecnico != '')
                                  ? _CustomButton(
                                      text: 'Asignar técnico',
                                      color: Color(0xff28A745),
                                      onPressed: () {
                                        _asignarTecnicoDialog(context);
                                      },
                                    )
                                  : Container(),
                              const SizedBox(width: 10),
                              _CustomButton(
                                text: 'Cerrar solicitud',
                                color: Colors.redAccent,
                                onPressed: () {
                                  _cerrarColicitudDialog(context);
                                },
                              ),
                              // ElevatedButton(
                              //     onPressed: () {},
                              //     child: Text('Cerrar solicitud')),
                              // CustomElevatedButton(text: 'Asignar técnico'),
                              // CustomElevatedButton(text: 'Cerrar solicitud'),
                            ],
                          ),
                        )
                      : Center(
                          child: _CustomButton(
                            text: 'Atender solicitud',
                            color: Colors.blue,
                            onPressed: () {
                              showDialog(
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
                                            child: Text(
                                                'Fecha de cierre programado:'),
                                          ),
                                          const SizedBox(height: 15),
                                          CustomDateTimePicker(
                                              controller: fechaCierreCtrl),
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
                            },
                          ),
                        ),
                  // : CustomElevatedButton(text: 'Atender Solicitud'),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
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
