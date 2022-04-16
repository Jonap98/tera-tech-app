// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyImage extends StatelessWidget {
  final String url;

  const MyImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = url;
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      imageUrl,
      (int _) => ImageElement()..src = imageUrl,
    );
    return HtmlElementView(
      viewType: imageUrl,
    );
  }
}
