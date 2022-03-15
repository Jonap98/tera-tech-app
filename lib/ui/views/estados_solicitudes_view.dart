// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';

class EstadosSolicitudesView extends StatelessWidget {
  const EstadosSolicitudesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: double.infinity,
      // margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(50),
      child: Wrap(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              'Estados',
              style: CustomLabels.h1,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            child: const _CustomDropDown(titulo: 'Seleccionar técnico'),
            width: 200,
          ),
          Container(
            child: const _CustomDropDown(titulo: 'Seleccionar cliente'),
            width: 200,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Buscar'),
          ),
          Wrap(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              EstadoElement(
                  estado: 'Sin resolver',
                  icon: Icons.markunread,
                  cantidad: 30,
                  onPressed: () {
                    NavigationService.navigateTo(
                        Flurorouter.solicitudesEstadosRoute);
                  }
                  // onPressed: NavigationService.navigateTo(
                  //     Flurorouter.solicitudesEstadosRoute),
                  ),
              EstadoElement(
                  estado: 'Abierto',
                  icon: Icons.drafts,
                  cantidad: 3,
                  onPressed: () {
                    NavigationService.navigateTo(
                        Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'Asignado',
                  icon: Icons.assignment_ind,
                  cantidad: 0,
                  onPressed: () {
                    NavigationService.navigateTo(
                        Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'En espera',
                  icon: Icons.watch_later,
                  cantidad: 9,
                  onPressed: () {
                    NavigationService.navigateTo(
                        Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'Detalle',
                  icon: Icons.assignment_return,
                  cantidad: 5,
                  onPressed: () {
                    NavigationService.navigateTo(
                        Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'Listo',
                  icon: Icons.assignment_turned_in,
                  cantidad: 10,
                  onPressed: () {
                    NavigationService.navigateTo(
                        Flurorouter.solicitudesEstadosRoute);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

class EstadoElement extends StatelessWidget {
  final String estado;
  final IconData icon;
  final int cantidad;
  final VoidCallback? onPressed;

  const EstadoElement({
    required this.estado,
    required this.icon,
    this.onPressed,
    this.cantidad = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(estado, style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  (cantidad != 0)
                      ? NotificationCount(cantidad: cantidad)
                      : Container()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCount extends StatelessWidget {
  final int cantidad;

  const NotificationCount({
    required this.cantidad,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      top: 10,
      child: Container(
        width: 25,
        height: 25,
        child: Center(
            child: Text(
          (cantidad <= 9) ? '$cantidad' : '+9',
          style: TextStyle(color: Colors.white),
        )),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
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
