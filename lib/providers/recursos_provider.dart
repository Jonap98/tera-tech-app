import 'package:flutter/material.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/clientes_model.dart';
import 'package:tera_tech_app/models/tecnicos_model.dart';

class RecursosProvider extends ChangeNotifier {
  Future<List<DatoTecnico>> getTecnicos() async {
    final resp = await CafeApi.httpGet('/tecnicos');
    final tecnicosResp = Tecnicos.fromMap(resp);

    notifyListeners();
    return tecnicosResp.datos;
  }

  late DatoTecnico _tecnicoSeleccionado = DatoTecnico(
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
}
