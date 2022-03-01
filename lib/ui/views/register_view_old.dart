// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:tera_tech_app/ui/buttons/boton_azul.dart';
import 'package:tera_tech_app/ui/inputs/custom_input.dart';

class RegisterViewOld extends StatelessWidget {
  const RegisterViewOld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      color: const Color(0xff0A1E3C),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registro',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const CustomInput(
                  icon: Icon(Icons.mail),
                  text: 'Nombre',
                ),
                const SizedBox(height: 10),
                const CustomInput(
                  icon: Icon(Icons.mail),
                  text: 'Apellido',
                ),
                const SizedBox(height: 10),
                const CustomInput(
                  icon: Icon(Icons.mail),
                  text: 'Email',
                ),
                const SizedBox(height: 10),
                const CustomInput(
                  icon: Icon(Icons.lock),
                  text: 'Contraseña',
                ),
                const SizedBox(height: 10),
                const CustomInput(
                  icon: Icon(Icons.lock),
                  text: 'Confirmar contraseña',
                ),
                const SizedBox(height: 10),
                CustomElevatedButton(
                  text: 'Ingresar',
                  onPressed: () {},
                ),
                const SizedBox(height: 10),
                // const Labels(
                //     pregunta: '¿Aún no tienes una cuenta?',
                //     boton: 'Registrate.',
                //     ruta: '404'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
