// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('404 - Not found',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)
            // style: GoogleFonts.montserratAlternates(
            //   fontSize: 50,
            //   fontWeight: FontWeight.bold,
            // ),
            ),
      ),
    );
  }
}
