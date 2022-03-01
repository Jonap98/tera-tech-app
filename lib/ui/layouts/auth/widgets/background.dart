import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: boxDecorationImage(),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Image(
                image: AssetImage('Logo.png'),
                width: 400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecorationImage() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('engineer.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}
