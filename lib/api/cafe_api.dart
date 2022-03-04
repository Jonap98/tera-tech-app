// ignore_for_file: prefer_final_fields, avoid_print

import 'package:dio/dio.dart';
import 'package:tera_tech_app/services/local_storage.dart';

class CafeApi {
  static Dio _dio = Dio();

  static void configureDio() {
    // Base del URL
    _dio.options.baseUrl = 'http://127.0.0.1:8000/api';

    // Headers
    _dio.options.headers = {
      'Authorization': 'Bearer ${LocalStorage.prefs.getString('key')}'
    };
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);

      return resp.data;
    } catch (e) {
      print(e);
      throw ('Error en el GET');
    }
  }
}
