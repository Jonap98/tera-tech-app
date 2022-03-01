// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/ui/buttons/boton_azul.dart';
import 'package:tera_tech_app/ui/inputs/custom_input.dart';
import 'package:tera_tech_app/ui/layouts/auth/widgets/labels.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Image.asset(
          'Logo.png',
          width: 150,
          height: 100,
        ),
        const Text(
          'Iniciar sesión',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          //Mío
          // padding: const EdgeInsets.all(30),
          // Fernando
          // margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color(0xff0A1E3C),
          child: Center(
            // child: MyForm(),
            // Implementación Fernando Herrera
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370, maxHeight: 300),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                child: Form(
                    child: Column(
                  children: [
                    TextFormField(
                      // validator: ,
                      style: const TextStyle(color: Colors.white),
                      decoration: buildInputDecoration(
                        hint: 'Ingrese su correo',
                        label: 'Email',
                        icon: Icons.mail,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      // validator: ,
                      style: const TextStyle(color: Colors.white),
                      decoration: buildInputDecoration(
                        hint: 'Ingrese su contraseña',
                        label: 'Password',
                        icon: Icons.lock,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(
                      // color: Colors.pinkAccent,
                      // isFilled: false,
                      text: 'Ingresar',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    Labels(
                      pregunta: '¿Aún no tienes una cuenta?',
                      boton: 'Registrate.',
                      onTap: () => Navigator.pushNamed(
                          context, Flurorouter.registerRoute),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration buildInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(5),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
    );
  }
}

class MyForm extends StatelessWidget {
  const MyForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              'Iniciar sesión',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CustomInput(
              icon: Icon(Icons.mail),
              text: 'Email',
            ),
            const SizedBox(height: 20),
            const CustomInput(
              icon: Icon(Icons.lock),
              text: 'Contraseña',
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'Ingresar',
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            Labels(
              pregunta: '¿Aún no tienes una cuenta?',
              boton: 'Registrate.',
              onTap: () =>
                  Navigator.pushNamed(context, Flurorouter.registerRoute),
            ),
          ],
        ),
      ),
    );
  }
}
