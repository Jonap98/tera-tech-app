// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class WhiteView extends StatelessWidget {
  const WhiteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<AuthProvider>(context).user;

    return Container(
      child: Center(
        child: Column(
          children: const [
            Text('Página de prueba',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)
                // style: GoogleFonts.montserratAlternates(
                //   fontSize: 50,
                //   fontWeight: FontWeight.bold,
                // ),
                ),
            // Text('${user!.lastName}')
          ],
        ),
      ),
    );
  }
}
