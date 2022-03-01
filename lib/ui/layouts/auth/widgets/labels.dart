import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String pregunta;
  final String boton;
  final VoidCallback? onTap;

  const Labels({
    Key? key,
    required this.pregunta,
    required this.boton,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          '$pregunta ',
          style: const TextStyle(
              color: Colors.black54,
              fontSize: 15.0,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 16.0),
        GestureDetector(
          onTap: onTap,
          // onTap: () => Navigator.pushReplacementNamed(context, ruta),
          child: Text(
            boton,
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
