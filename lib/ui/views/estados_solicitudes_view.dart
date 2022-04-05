// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/models/clientes_model.dart';
import 'package:tera_tech_app/models/tecnicos_model.dart';
import 'package:tera_tech_app/providers/recursos_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';

class EstadosSolicitudesView extends StatelessWidget {
  const EstadosSolicitudesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatoTecnico? tecnicoSeleccionado;
    DatoCliente? clienteSeleccionado;

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
            child: _DropdownTecnicos(selectedValue: tecnicoSeleccionado),
            width: 210,
          ),
          Container(
            child: _DropdownClientes(selectedValue: clienteSeleccionado),
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
                    NavigationService.navigateTo(Flurorouter.whiteRoute);
                    // NavigationService.navigateTo(
                    //     Flurorouter.solicitudesEstadosRoute);
                  }
                  // onPressed: NavigationService.navigateTo(
                  //     Flurorouter.solicitudesEstadosRoute),
                  ),
              EstadoElement(
                  estado: 'Abierto',
                  icon: Icons.drafts,
                  cantidad: 3,
                  onPressed: () {
                    NavigationService.navigateTo(Flurorouter.whiteRoute);
                    // NavigationService.navigateTo(
                    //     Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'Asignado',
                  icon: Icons.assignment_ind,
                  cantidad: 0,
                  onPressed: () {
                    NavigationService.navigateTo(Flurorouter.whiteRoute);
                    // NavigationService.navigateTo(
                    //     Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'En espera',
                  icon: Icons.watch_later,
                  cantidad: 9,
                  onPressed: () {
                    NavigationService.navigateTo(Flurorouter.whiteRoute);
                    // NavigationService.navigateTo(
                    //     Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'Detalle',
                  icon: Icons.assignment_return,
                  cantidad: 5,
                  onPressed: () {
                    NavigationService.navigateTo(Flurorouter.whiteRoute);
                    // NavigationService.navigateTo(
                    //     Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'Listo',
                  icon: Icons.assignment_turned_in,
                  cantidad: 10,
                  onPressed: () {
                    NavigationService.navigateTo(Flurorouter.whiteRoute);
                    // NavigationService.navigateTo(
                    //     Flurorouter.solicitudesEstadosRoute);
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
                  // (cantidad != 0)
                  //     ? NotificationCount(cantidad: cantidad)
                  //     : Container()
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

class _DropdownClientes extends StatefulWidget {
  DatoCliente? selectedValue;

  _DropdownClientes({
    Key? key,
    this.selectedValue,
  }) : super(key: key);

  @override
  State<_DropdownClientes> createState() => _DropdownClientesState();
}

class _DropdownClientesState extends State<_DropdownClientes> {
  // String? selectedValue;
  // final opciones = [
  //   'Opción 1',
  //   'Opción 2',
  //   'Opción 3',
  //   'Opción 4',
  //   'Opción 5',
  // ];

  late Future<List<DatoCliente>> clientes;
  @override
  void initState() {
    super.initState();
    clientes =
        Provider.of<RecursosProvider>(context, listen: false).getClientes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DatoCliente>>(
      future: clientes,
      builder: (context, AsyncSnapshot<List<DatoCliente>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField<DatoCliente>(
            hint: const Text('Selecciona un cliente'),
            value: widget.selectedValue,
            // value: (selectedValue != '') ? '' : 'Selecciona una categoría',
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
            dropdownColor: const Color(0xffEDF1F2),
            icon: const Icon(Icons.arrow_drop_down),
            items: snapshot.data!
                .map<DropdownMenuItem<DatoCliente>>((DatoCliente opcion) {
              return DropdownMenuItem(
                value: opcion,
                child: Text(opcion.name),
              );
            }).toList(),
            // items: opciones.map((String opciones) {
            //   return DropdownMenuItem(
            //     value: opciones,
            //     child: Text(opciones),
            //   );
            // }).toList(),
            onChanged: (DatoCliente? newValue) {
              widget.selectedValue = newValue!;
              // print(selectedValue!.id);
              // print(selectedValue!.nombre);
              Provider.of<RecursosProvider>(context, listen: false)
                  .cargarCliente(widget.selectedValue!);
              setState(() {});
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _DropdownTecnicos extends StatefulWidget {
  DatoTecnico? selectedValue;

  _DropdownTecnicos({
    Key? key,
    this.selectedValue,
  }) : super(key: key);

  @override
  State<_DropdownTecnicos> createState() => _DropdownTecnicosState();
}

class _DropdownTecnicosState extends State<_DropdownTecnicos> {
  // String? selectedValue;
  // final opciones = [
  //   'Opción 1',
  //   'Opción 2',
  //   'Opción 3',
  //   'Opción 4',
  //   'Opción 5',
  // ];

  late Future<List<DatoTecnico>> tecnicos;
  @override
  void initState() {
    super.initState();
    tecnicos =
        Provider.of<RecursosProvider>(context, listen: false).getTecnicos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DatoTecnico>>(
      future: tecnicos,
      builder: (context, AsyncSnapshot<List<DatoTecnico>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField<DatoTecnico>(
            hint: const Text('Selecciona un tecnico'),
            value: widget.selectedValue,
            // value: (selectedValue != '') ? '' : 'Selecciona una categoría',
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
            dropdownColor: const Color(0xffEDF1F2),
            icon: const Icon(Icons.arrow_drop_down),
            items: snapshot.data!
                .map<DropdownMenuItem<DatoTecnico>>((DatoTecnico opcion) {
              return DropdownMenuItem(
                value: opcion,
                child: Text(opcion.name),
              );
            }).toList(),
            // items: opciones.map((String opciones) {
            //   return DropdownMenuItem(
            //     value: opciones,
            //     child: Text(opciones),
            //   );
            // }).toList(),
            onChanged: (DatoTecnico? newValue) {
              widget.selectedValue = newValue!;
              // print(selectedValue!.id);
              // print(selectedValue!.nombre);
              Provider.of<RecursosProvider>(context, listen: false)
                  .cargarTecnico(widget.selectedValue!);
              setState(() {});
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
