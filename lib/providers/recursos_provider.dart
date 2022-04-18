import 'package:flutter/material.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/clientes_model.dart';
import 'package:tera_tech_app/models/especialidades_model.dart';
import 'package:tera_tech_app/models/estados_model.dart';
import 'package:tera_tech_app/models/roles_model.dart';
import 'package:tera_tech_app/models/tecnicos_model.dart';

class RecursosProvider extends ChangeNotifier {
  Future<List<DatoTecnico>> getTecnicos() async {
    final resp = await CafeApi.httpGet('/tecnicos');
    final tecnicosResp = Tecnicos.fromMap(resp);

    // tecnicosResp.datos.forEach((element) {
    //   print(element.name);
    // });

    notifyListeners();
    return tecnicosResp.datos;
  }

  Future<List<DatoTecnico>> getTecnicoPorId(int idTecnico) async {
    final resp = await CafeApi.httpGet('/tecnicos?idUser=$idTecnico');
    //         .then((value) {
    //   cargarTecnico(Tecnicos.fromMap(value).datos.first);
    // });
    final tecnicosResp = Tecnicos.fromMap(resp);

    _tecnicoSeleccionado = tecnicosResp.datos.first;

    notifyListeners();
    return tecnicosResp.datos;
  }

  late DatoTecnico _tecnicoSeleccionado = DatoTecnico(
      id: -1,
      idRol: -1,
      idEspecialidad: -1,
      name: '',
      lastName: '',
      email: '',
      especialidad: '');
  cargarTecnico(DatoTecnico tecnicoSeleccionado) {
    _tecnicoSeleccionado = tecnicoSeleccionado;
    notifyListeners();
  }

  DatoTecnico get obtenerTecnicoSeleccionado {
    return _tecnicoSeleccionado;
  }

  late Rol _rolSeleccionado = Rol(id: -1, nombre: '');
  cargarRol(Rol rolSeleccionado) {
    _rolSeleccionado = rolSeleccionado;
    notifyListeners();
  }

  Rol get obtenerRolSeleccionado {
    return _rolSeleccionado;
  }

  late Especialidad _especialidadSeleccionada =
      Especialidad(id: -1, nombre: '');
  cargarEspecialidad(Especialidad especialidadSeleccionada) {
    _especialidadSeleccionada = especialidadSeleccionada;
    notifyListeners();
  }

  Especialidad get obtenerEspecialidad {
    return _especialidadSeleccionada;
  }

  eliminarRecursos() {
    _rolSeleccionado = Rol(id: -1, nombre: '');
    _especialidadSeleccionada = Especialidad(id: -1, nombre: '');
  }

  Future<List<DatoCliente>> getClientes() async {
    final resp = await CafeApi.httpGet('/clientes');
    final clientesResp = Clientes.fromMap(resp);

    notifyListeners();
    return clientesResp.datos;
  }

  late DatoCliente _clienteSeleccionado =
      DatoCliente(idRol: -1, name: '', lastName: '', email: '');
  cargarCliente(DatoCliente clienteSeleccionado) {
    _clienteSeleccionado = clienteSeleccionado;
    notifyListeners();
  }

  DatoCliente get obtenerClienteSeleccionado {
    return _clienteSeleccionado;
  }

  Estado _estado = Estado(id: -1, nombre: '');
  cargarEstado(Estado estado) {
    _estado = estado;
    notifyListeners();
  }

  Estado get obtenerEstado {
    return _estado;
  }

  eliminarEstado(int idEstado) {
    _estado = Estado(id: -1, nombre: '');
    notifyListeners();
  }

  int _idSolicitud = 0, _idEstado = 0, _idTecnico = 0;
  cargarIdsSolicitud(int idSolicitud, int idEstado) {
    _idSolicitud = idSolicitud;
    _idEstado = idEstado;
    // _idTecnico = idTecnico!;

    notifyListeners();
  }

  int get obtenerIdSolicitud {
    return _idSolicitud;
  }

  int get obtenerIdEstado {
    return _idEstado;
  }

  int get obtenerIdTecnico {
    return _idTecnico;
  }
}
