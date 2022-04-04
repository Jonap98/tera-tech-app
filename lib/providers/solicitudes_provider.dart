import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/categorias_model.dart';
import 'package:tera_tech_app/models/solicitudes_model.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
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
    BuildContext context,
    int idUsuario,
    int idCategoria,
    String? descripcion,
    String fechaCita,
    PlatformFile imagen,
  ) {
    final data = {
      'id_usuario': idUsuario,
      'id_categoria': idCategoria,
      'id_estado': 1,
      'descripcion': descripcion,
      'fecha_cita': fechaCita,
      'imagen': (imagen.name.isNotEmpty)
          ? MultipartFile.fromBytes(imagen.bytes!,
              filename: imagen.name,
              headers: {
                  'Content-Type': ['multipart/form-data']
                })
          : null,
    };

    CafeApi.httpPost('/crear-solicitud', data).then((json) {
      NotificationService.solicitudExitosa(
          context, 'Solicitud creada exitosamente');
      // NavigationService.navigateTo(Flurorouter.whiteRoute);

      CafeApi.configureDio();

      notifyListeners();
      return true;
    }).catchError((e) {
      NotificationService.showSnackbarError('Error');
      // print(e);
      return false;
    });
    return false;
  }

  // Cargas y getters
  // PlatformFile? _file;
  late PlatformFile _file = PlatformFile(name: '', size: 0);
  cargatInformacionImagen(PlatformFile file) {
    _file = file;
    notifyListeners();
  }

  PlatformFile get obtenerInformacionImagen {
    return _file;
  }

  String _image = '';
  cargarNombreImagen(String image) {
    _image = image;
    notifyListeners();
  }

  Uint8List? _imageBytes;
  cargarImagen(Uint8List bytes) {
    _imageBytes = bytes;
  }

  Uint8List get obtenerImagenBytes {
    return _imageBytes!;
  }

  String get obtenerImage {
    return _image;
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
