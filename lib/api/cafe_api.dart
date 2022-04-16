// ignore_for_file: prefer_final_fields, avoid_print

// import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:tera_tech_app/services/local_storage.dart';

class CafeApi {
  static Dio _dio = Dio();
  static Dio _dio2 = Dio();

  static void configureDio() async {
    // Base del URL
    _dio.options.baseUrl = 'http://127.0.0.1:8000/api';
    // Base URL NGROK
    // _dio.options.baseUrl = '$url/api';
    // Url Ngrok
    // _dio.options.baseUrl = 'https://66e4-201-172-233-80.ngrok.io/api';

    // Url ngrok
    // final url = await obtenerUrl();
    // _dio.options.baseUrl = '${url.toString()}/api';

    // Headers
    _dio.options.headers = {
      'Content-Type': 'application/json',
      // 'Content-Type': 'multipart/form-data',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer ${LocalStorage.prefs.getString('token')}',
    };
  }

  static getUrl() {
    return _dio.options.baseUrl.substring(0, _dio.options.baseUrl.length - 4);
  }

  static obtenerUrl() async {
    final resp = await _dio2
        .get('https://teratech-app-default-rtdb.firebaseio.com/apiUrl.json');
    // httpGet('https://teratech-app-default-rtdb.firebaseio.com/apiUrl.json');
    // print(resp);
    return resp;
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);

      return resp.data;
    } catch (e) {
      // print(e);
      throw ('Error en el GET');
    }
  }

  static Future httpPost(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(path, data: formData);

      return resp.data;
    } catch (e) {
      print(e);
      throw ('Error en el POST');
    }
  }

  // static Future uploadFile(String path, Uint8List bytes) async {
  //   final formData = FormData.fromMap({
  //     'imagen': MultipartFile.fromBytes(bytes),
  //   });

  //   try {
  //     final resp = await _dio.post(path, data: formData);

  //     return resp.data;
  //   } on DioError catch (e) {
  //     throw ('Error en el Put $e');
  //   }
  // }
}
