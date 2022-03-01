import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String text;
  const LinkText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Hola',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
