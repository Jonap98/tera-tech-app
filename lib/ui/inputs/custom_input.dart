import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final Icon icon;
  final String text;

  const CustomInput({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: icon,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: text,
        ),
      ),
    );
  }
}
