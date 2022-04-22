import 'dart:typed_data';
// import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/categorias_model.dart';
import 'package:tera_tech_app/models/disponibilidad_citas.dart';
import 'package:tera_tech_app/models/solicitudes_model.dart';
import 'package:tera_tech_app/router/router.dart';
// import 'package:tera_tech_app/router/router.dart';
// import 'package:tera_tech_app/services/local_storage.dart';
// import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/services/notification_service.dart';

class SolicitudesProvider extends ChangeNotifier {
  late SolicitudesResponse solicitudes;

  getSolicitudes() async {
    // CafeApi.configureDio();

    // print(idUsuario);
    final resp = await CafeApi.httpGet('/solicitudes');
    // print(resp);
    final solicitudesResp = SolicitudesResponse.fromMap(resp);

    solicitudes = solicitudesResp;

    notifyListeners();

    // return solicitudes;

    // print(solicitudes);
  }

  Future<SolicitudesResponse> getSolicitudesUsuario(int idUsuario) async {
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

  Future<SolicitudesResponse> getSolicitudesEstado(
      int? idSolicitud, int idEstado) async {
    // CafeApi.configureDio();

    // print(idUsuario);
    late dynamic resp;
    if (idSolicitud != null) {
      resp = await CafeApi.httpGet(
          '/solicitudes?id=$idSolicitud&idEstado=$idEstado');
    } else {
      resp = await CafeApi.httpGet('/solicitudes?idEstado=$idEstado');
    }
    // print(resp);
    final solicitudesResp = SolicitudesResponse.fromMap(resp);

    solicitudes = solicitudesResp;

    notifyListeners();

    return solicitudes;

    // print(solicitudes);
  }

  Future<SolicitudesResponse> getSolicitudesEstadoTecnico(
      int? idSolicitud, int idEstado, int idTecnico) async {
    // CafeApi.configureDio();

    // print(idUsuario);
    late dynamic resp;
    if (idSolicitud != null) {
      resp = await CafeApi.httpGet(
          '/solicitudes?id=$idSolicitud&idEstado=$idEstado&idTecnico=$idTecnico');
    } else {
      resp = await CafeApi.httpGet(
          '/solicitudes?idEstado=$idEstado&idTecnico=$idTecnico');
    }
    // print(resp);
    final solicitudesResp = SolicitudesResponse.fromMap(resp);

    solicitudes = solicitudesResp;

    notifyListeners();

    return solicitudes;

    // print(solicitudes);
  }

  Future<SolicitudesResponse> getSolicitudesFiltro(
      int? idCliente, int? idTecnico) async {
    // CafeApi.configureDio();
    late dynamic resp;

    if (idCliente != -1 && idTecnico == -1) {
      resp = await CafeApi.httpGet('/solicitudes?idCliente=$idCliente');
    } else if (idCliente == -1 && idTecnico != -1) {
      resp = await CafeApi.httpGet('/solicitudes?idTecnico=$idTecnico');
    } else if (idCliente != -1 && idTecnico != -1) {
      resp = await CafeApi.httpGet(
          '/solicitudes?idCliente=$idCliente&idTecnico=$idTecnico');
    } else {
      resp = await CafeApi.httpGet('/solicitudes?idCliente=-1&idTecnico=-1');
    }

    // print(idUsuario);
    // late dynamic resp;
    // if (idCliente != null) {
    //   resp = await CafeApi.httpGet(
    //       '/solicitudes?id=$idSolicitud&idEstado=$idEstado');
    // } else {
    //   resp = await CafeApi.httpGet('/solicitudes?idEstado=$idEstado');
    // }
    // print('/solicitudes?idCliente=${idCliente!}&idEstado=${idTecnico!}');
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
          context, 'Solicitud creada exitosamente', Flurorouter.dashboardRoute);
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

  bool asignarTecnico(
    BuildContext context,
    int idSolicitud,
    int idTecnico,
  ) {
    final data = {
      'id_tecnico': idTecnico,
    };

    CafeApi.httpPost('/asignar-tecnico/$idSolicitud', data).then((json) {
      NotificationService.solicitudExitosa(context,
          'Técnico asignado exitosamente', Flurorouter.estadosSoporteRoute);

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

  bool atenderSolicitud(
    BuildContext context,
    int idSolicitud,
    bool detalle,
    String comentario,
    String fechaListo,
  ) {
    final data = {
      'detalle': (detalle) ? 1 : 0,
      'comentario': (comentario.isNotEmpty) ? comentario.toString() : null,
      'fecha_listo': fechaListo.toString(),
    };

    // print('Data: $data');

    CafeApi.httpPost('/atender-solicitud/$idSolicitud', data).then((json) {
      Provider.of<SolicitudesProvider>(context, listen: false)
          .inicializarDetalle();
      NotificationService.solicitudExitosa(
          context,
          'Solicitud actualizada exitosamente',
          Flurorouter.estadosSoporteRoute);
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

  bool cerrarSolicitud(
    BuildContext context,
    int idSolicitud,
  ) {
    CafeApi.httpPut2('/cerrar-solicitud/$idSolicitud').then((json) {
      NotificationService.solicitudExitosa(context,
          'Solicitud cerrada exitosamente', Flurorouter.estadosSoporteRoute);
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

  String horarioSeleccionado = '00';
  seleccionarHorario(String horario) {
    horarioSeleccionado = horario;
    notifyListeners();
  }

  eliminarHorario() {
    horarioSeleccionado = '00';
    notifyListeners();
  }

  DisponibilidadCitas disponibilidadCitas = DisponibilidadCitas(
    result: true,
    fecha: '',
    disponibles: Disponibles(
      h11: false,
      h12: false,
      h13: false,
      h15: false,
      h16: false,
      h17: false,
    ),
  );
  Future<DisponibilidadCitas> verificarDisponibilidad(String fecha) async {
    final data = {
      'fecha_cita': fecha,
    };
    // final resp = await CafeApi.httpGet('/categorias');
    final resp = await CafeApi.httpPost('/citas', data);
    final disponibilidadResp = DisponibilidadCitas.fromMap(resp);
    disponibilidadCitas = disponibilidadResp;

    notifyListeners();

    return disponibilidadResp;
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

  eliminarImagen() {
    _file = PlatformFile(name: '', size: 0, bytes: null);
    notifyListeners();
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

  bool _disponibilidad = true;
  cargarDisponibilidad(bool disponibilidad) {
    _disponibilidad = disponibilidad;
    notifyListeners();
  }

  bool get obtenerDisponibilidad {
    return _disponibilidad;
  }

  bool _detalle = false;
  cargarDetalle(bool detalle) {
    _detalle = detalle;
    notifyListeners();
  }

  bool get obtenerDetalle {
    return _detalle;
  }

  inicializarDetalle() {
    _detalle = false;
    notifyListeners();
  }

  Dato _solicitud = Dato(
      id: -1,
      idUsuario: -1,
      idCategoria: -1,
      idEstado: -1,
      fechaCita: '',
      nombreCategoria: '',
      nombreEstado: '');
  cargarSolicitud(Dato solicitud) {
    _solicitud = solicitud;
    notifyListeners();
  }

  Dato get obtenerSolicitud {
    return _solicitud;
  }

  eliminarSolicitud() {
    _solicitud = Dato(
        id: -1,
        idUsuario: -1,
        idCategoria: -1,
        idEstado: -1,
        fechaCita: '',
        nombreCategoria: '',
        nombreEstado: '');
    notifyListeners();
  }

  bool _aplicaFiltros = false;
  aplicarFiltros() {
    _aplicaFiltros = true;
    notifyListeners();
  }

  bool get hayFiltros {
    return _aplicaFiltros;
  }

  eliminarFiltros() {
    _aplicaFiltros = false;
    notifyListeners();
  }
}
