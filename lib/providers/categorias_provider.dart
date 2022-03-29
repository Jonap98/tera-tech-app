import 'package:flutter/material.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/models/categorias_model.dart';

class CategoriasProvider extends ChangeNotifier {
  Future<Categorias> getCategorias() async {
    final resp = await CafeApi.httpGet('/categorias');
    final categoriasResp = Categorias.fromMap(resp);

    notifyListeners();
    return categoriasResp;
  }
}
