// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/models/clientes_model.dart';
import 'package:tera_tech_app/models/estados_model.dart';
import 'package:tera_tech_app/models/tecnicos_model.dart';
import 'package:tera_tech_app/providers/recursos_provider.dart';
import 'package:tera_tech_app/providers/solicitudes_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';
import 'package:tera_tech_app/ui/shared/widgets/dropdown_tecnicos.dart';

class EstadosSolicitudesView extends StatelessWidget {
  const EstadosSolicitudesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final idRol = LocalStorage.prefs.getInt('rol');
    final solicitudesProvider = Provider.of<SolicitudesProvider>(context);
    // idRol == 1 - Admin
    // idRol == 2 - Técnico

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
            child: _DropdownClientes(selectedValue: clienteSeleccionado),
            width: 200,
          ),
          (idRol == 1)
              ? Container(
                  child: DropdownTecnicos(selectedValue: tecnicoSeleccionado),
                  width: 210,
                )
              : Container(width: 20),
          ElevatedButton(
            onPressed: () {
              // final cliente =
              //     Provider.of<RecursosProvider>(context, listen: false)
              //         .obtenerClienteSeleccionado;
              // final tecnico =
              //     Provider.of<RecursosProvider>(context, listen: false)
              //         .obtenerTecnicoSeleccionado;

              // print('Cliente: ${cliente.name}');
              // print('Técnico: $tecnicoSeleccionado');
              solicitudesProvider.aplicarFiltros();
              // Provider.of<RecursosProvider>(context, listen: false)
              //     .cargarCliente(cliente);
              // Provider.of<RecursosProvider>(context, listen: false)
              //     .cargarTecnico(tecnico);
              Future.delayed(Duration(milliseconds: 300), () {
                NavigationService.navigateTo(
                    Flurorouter.solicitudesEstadosRoute);
              });
              // Provider.of<RecursosProvider>(context, listen: false)
              //     .cargarFiltros(
              //         clienteSeleccionado!.id, tecnicoSeleccionado!.id);
            },
            child: const Text('Buscar'),
          ),
          Wrap(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              (idRol == 1)
                  ? EstadoElement(
                      estado: 'Sin resolver',
                      icon: Icons.markunread,
                      cantidad: 30,
                      onPressed: () {
                        // NavigationService.navigateTo(Flurorouter.whiteRoute);
                        Provider.of<RecursosProvider>(context, listen: false)
                            .cargarEstado(
                                Estado(id: 1, nombre: 'Sin resolver'));
                        NavigationService.navigateTo(
                            Flurorouter.solicitudesEstadosRoute);
                      }
                      // onPressed: NavigationService.navigateTo(
                      //     Flurorouter.solicitudesEstadosRoute),
                      )
                  : Container(),
              (idRol == 1)
                  ? EstadoElement(
                      estado: 'Abierto',
                      icon: Icons.drafts,
                      cantidad: 3,
                      onPressed: () {
                        // NavigationService.navigateTo(Flurorouter.whiteRoute);
                        Provider.of<RecursosProvider>(context, listen: false)
                            .cargarEstado(Estado(id: 2, nombre: 'Abierto'));
                        NavigationService.navigateTo(
                            Flurorouter.solicitudesEstadosRoute);
                      })
                  : Container(),
              EstadoElement(
                  estado: 'Asignado',
                  icon: Icons.assignment_ind,
                  cantidad: 0,
                  onPressed: () {
                    // NavigationService.navigateTo(Flurorouter.whiteRoute);
                    Provider.of<RecursosProvider>(context, listen: false)
                        .cargarEstado(Estado(id: 3, nombre: 'Asignado'));
                    // Provider.of<RecursosProvider>(context)
                    //     .cargarEstado(Estado(id: 3, nombre: 'Asignado'));
                    NavigationService.navigateTo(
                        Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'En espera',
                  icon: Icons.watch_later,
                  cantidad: 9,
                  onPressed: () {
                    // NavigationService.navigateTo(Flurorouter.whiteRoute);
                    Provider.of<RecursosProvider>(context, listen: false)
                        .cargarEstado(Estado(id: 4, nombre: 'En espera'));
                    NavigationService.navigateTo(
                        Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'Detalle',
                  icon: Icons.assignment_return,
                  cantidad: 5,
                  onPressed: () {
                    // NavigationService.navigateTo(Flurorouter.whiteRoute);
                    Provider.of<RecursosProvider>(context, listen: false)
                        .cargarEstado(Estado(id: 5, nombre: 'Detalle'));
                    NavigationService.navigateTo(
                        Flurorouter.solicitudesEstadosRoute);
                  }),
              EstadoElement(
                  estado: 'Listo',
                  icon: Icons.assignment_turned_in,
                  cantidad: 10,
                  onPressed: () {
                    // NavigationService.navigateTo(Flurorouter.whiteRoute);
                    Provider.of<RecursosProvider>(context, listen: false)
                        .cargarEstado(Estado(id: 6, nombre: 'Listo'));
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
  late Future<List<DatoCliente>> clientes;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<RecursosProvider>(context, listen: false).eliminarCliente();
    });
    super.initState();
    clientes =
        Provider.of<RecursosProvider>(context, listen: false).getClientes();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<RecursosProvider>(context, listen: false).eliminarCliente();
  //   clientes =
  //       Provider.of<RecursosProvider>(context, listen: false).getClientes();
  // }**

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
