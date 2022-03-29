import 'package:flutter/material.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/categorias_model.dart';
import 'package:tera_tech_app/models/solicitudes_model.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/services/notification_service.dart';

class SolicitudesProvider extends ChangeNotifier {
  late SolicitudesResponse solicitudes;

  Future<SolicitudesResponse> getSolicitudes(int idUsuario) async {
    // CafeApi.configureDio();

    // print(idUsuario);
    final resp =
        await CafeApi.httpGet('/solicitudes-usuario?idUser=$idUsuario');
    // print(resp);
    final solicitudesResp = SolicitudesResponse.fromMap(resp);

    solicitudes = solicitudesResp;

    notifyListeners();

    return solicitudes;

    // print(solicitudes);
  }

  Future<List<DatoCategoria>> getCategorias() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriasResp = Categorias.fromMap(resp);

    notifyListeners();
    return categoriasResp.datos;
  }

  bool crearSolicitud(
    int idUsuario,
    int idCategoria,
    String? descripcion,
    String fechaCita, // String
    String? imagen,
  ) {
    final data = {
      'id_usuario': idUsuario,
      'id_categoria': idCategoria,
      'id_estado': 1,
      // 'id_tecnico': idTecnico,
      'descripcion': descripcion,
      'fecha_cita': fechaCita,
      'imagen': imagen,
    };
    // print('Datos:');
    // print('idUsuario: $idUsuario');
    // print('idCategoria: $idCategoria');
    // print('descripcion: $descripcion');
    // print('fechaCita: $fechaCita');
    // print('imagen: $imagen');

    CafeApi.httpPost('/crear-solicitud', data).then((json) {
      NavigationService.navigateTo(Flurorouter.whiteRoute);

      CafeApi.configureDio();

      notifyListeners();
      return true;
    }).catchError((e) {
      NotificationService.showSnackbarError('Error');
      return false;
    });
    return false;
  }

  late DatoCategoria _selectedValue = DatoCategoria(id: -1, nombre: '');
  cargarSelectedValue(DatoCategoria selectedValue) {
    _selectedValue = selectedValue;
    notifyListeners();
  }

  DatoCategoria get obtenerSelectedValue {
    return _selectedValue;
  }

  String _fecha = '';
  cargarFecha(String fecha) {
    _fecha = fecha;
    notifyListeners();
  }

  String get obtenerFecha {
    return _fecha;
  }
}
