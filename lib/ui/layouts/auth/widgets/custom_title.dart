import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Image.asset(
                'Logo.png',
                width: 150,
                height: 150,
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          // const FittedBox(
          //   fit: BoxFit.contain,
          //   child: Text(
          //     'Iniciar sesión',
          //     style: TextStyle(
          //       fontSize: 40,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
