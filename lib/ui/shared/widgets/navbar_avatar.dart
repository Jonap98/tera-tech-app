import 'package:flutter/material.dart';

class NavbarAvatar extends StatelessWidget {
  final String name;
  final String lastName;

  const NavbarAvatar({
    Key? key,
    this.name = 'M',
    this.lastName = 'G',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    name.substring(0);
    lastName.substring(0);
    return Container(
      alignment: Alignment.center,
      // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      // padding: const EdgeInsets.only(top: 5, left: 12),
      height: 40,
      width: 40,
      child: Text(
        '${name.substring(0, 1).toUpperCase()}${lastName.substring(0, 1).toUpperCase()} ',
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        shape: BoxShape.circle,
      ),
    );
  }
}
