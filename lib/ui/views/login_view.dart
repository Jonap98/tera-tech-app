// ignore_for_file: avoid_unnecessary_containers, curly_braces_in_flow_control_structures

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/providers/auth_provider.dart';
import 'package:tera_tech_app/providers/login_form_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/ui/buttons/boton_azul.dart';
import 'package:tera_tech_app/ui/inputs/custom_input.dart';
import 'package:tera_tech_app/ui/layouts/auth/widgets/labels.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
        ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
          // Se realiza esta implementación del builder ya que el builder
          // construye primero todo lo que está en el builder, y luego, el
          //Widget Builder como tal, de esa manera, podemos utilizar:
          // final provider = Provider.of... de manera similar a como
          // se hace en el build cuando se crea el view

          // Cree un método porque ya había crecido mucho la identación
          child: formBuilder(authProvider),
        ),
      ],
    );
  }

  Builder formBuilder(AuthProvider authProvider) {
    return Builder(
      builder: (context) {
        final loginFormProvider =
            Provider.of<LoginFormProvider>(context, listen: false);

        return Container(
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
              constraints: const BoxConstraints(maxWidth: 370, maxHeight: 330),
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
                    key: loginFormProvider.formKey,
                    // autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        // Campo Email
                        TextFormField(
                          onChanged: (value) => loginFormProvider.email = value,
                          validator: (value) {
                            if (!EmailValidator.validate(value ?? ''))
                              return 'Email no válido';
                            else
                              return null;
                          },
                          style: const TextStyle(),
                          decoration: buildInputDecoration(
                            hint: 'Ingrese su correo',
                            label: 'Email',
                            icon: Icons.mail,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Campo contraseña
                        TextFormField(
                          onChanged: (value) =>
                              loginFormProvider.password = value,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'La contraseña es obligatoria';
                            if (value.length < 6)
                              return 'La contraseña debe tener 6 caracteres';

                            return null; // Válido, ya que devuelve el error
                          },
                          style: const TextStyle(),
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
                          onPressed: () {
                            final isValidForm =
                                loginFormProvider.validateForm();
                            if (isValidForm)
                              authProvider.login(
                                loginFormProvider.email,
                                loginFormProvider.password,
                              );
                          },
                        ),
                        const SizedBox(height: 10),
                        Labels(
                          pregunta: '¿Aún no tienes una cuenta?',
                          boton: 'Registrate.',
                          // Es valido usar pushNamed en vistas del mismo layout
                          onTap: () => Navigator.pushNamed(
                              context, Flurorouter.registerRoute),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        );
      },
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
