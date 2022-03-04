import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Image.asset(
        'WhiteLogo.png',
        width: 100,
        height: 100,
      ),
    );
  }
}
