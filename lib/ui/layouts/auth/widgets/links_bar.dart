// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tera_tech_app/ui/buttons/link_text.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Wrap(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          LinkText(
            text: 'Text',
          ),
        ],
      ),
    );
  }
}
