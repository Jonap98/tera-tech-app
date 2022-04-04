// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:tera_tech_app/services/local_storage.dart';

class CafeApi {
  static Dio _dio = Dio();

  static void configureDio() {
    // Base del URL
    // _dio.options.baseUrl = 'http://127.0.0.1:8000/api';
    // Base URL NGROK
    _dio.options.baseUrl =
        'https://7ec6-2806-2f0-3260-c0f-d0ef-3798-9e39-4b30.ngrok.io/api';

    // Headers
    _dio.options.headers = {
      'Content-Type': 'application/json',
      // 'Content-Type': 'multipart/form-data',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer ${LocalStorage.prefs.getString('token')}',
    };
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
