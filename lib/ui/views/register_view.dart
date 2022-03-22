// ignore_for_file: avoid_unnecessary_containers, curly_braces_in_flow_control_structures

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/providers/auth_provider.dart';
import 'package:tera_tech_app/providers/register_form_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/ui/buttons/boton_azul.dart';
// import 'package:tera_tech_app/ui/inputs/custom_input.dart';
import 'package:tera_tech_app/ui/layouts/auth/widgets/labels.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Image.asset(
            'WhiteLogo.png',
            width: 150,
            height: 100,
          ),
          const Text(
            'Registro',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          ChangeNotifierProvider(
            create: (_) => RegisterFormProvider(),
            child: formBuilder(),
          ),
        ],
      ),
    );
  }

  Builder formBuilder() {
    return Builder(
      builder: (context) {
        final registerFormProvider = Provider.of<RegisterFormProvider>(context);

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
              constraints: const BoxConstraints(
                  maxWidth: 370, maxHeight: double.infinity),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    key: registerFormProvider.formKey,
                    child: Column(
                      children: [
                        // Nombre
                        TextFormField(
                          onChanged: (value) =>
                              registerFormProvider.name = value,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'El nombre es obligatorio';
                            if (value.length > 100)
                              return 'Demasiados caracteres';

                            return null;
                          },
                          decoration: buildInputDecoration(
                            hint: 'Ingrese su nombre',
                            label: 'Nombre',
                            icon: Icons.account_circle,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Apellido
                        TextFormField(
                          onChanged: (value) =>
                              registerFormProvider.lastName = value,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'El apellido es obligatorio';
                            if (value.length > 100)
                              return 'Demasiados caracteres';

                            return null;
                          },
                          decoration: buildInputDecoration(
                            hint: 'Ingrese su Apellido',
                            label: 'Apellido',
                            icon: Icons.badge,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Email
                        TextFormField(
                          onChanged: (value) =>
                              registerFormProvider.email = value,
                          validator: (value) {
                            if (!EmailValidator.validate(value ?? ''))
                              return 'Email no válido';
                            else
                              return null;
                          },
                          decoration: buildInputDecoration(
                            hint: 'Ingrese su correo',
                            label: 'Email',
                            icon: Icons.mail,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Contraseña
                        TextFormField(
                          obscureText: true,
                          onChanged: (value) =>
                              registerFormProvider.password = value,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'La contraseña es obligatoria';
                            if (value.length < 6)
                              return 'La contraseña debe tener 6 caracteres';

                            return null; // Válido, ya que devuelve el error
                          },
                          decoration: buildInputDecoration(
                            hint: 'Ingrese su contraseña',
                            label: 'Contraseña',
                            icon: Icons.lock,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Confirmar contraseña
                        TextFormField(
                          obscureText: true,
                          onChanged: (value) =>
                              registerFormProvider.passwordConfirmation = value,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'La contraseña es obligatoria';
                            if (value.length < 6)
                              return 'La contraseña debe tener 6 caracteres';
                            if (value != registerFormProvider.password)
                              return 'Las contraseñas no coinciden';

                            return null; // Válido, ya que devuelve el error
                          },
                          decoration: buildInputDecoration(
                            hint: 'Confirme su contraseña',
                            label: 'Confirmación',
                            icon: Icons.lock,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomElevatedButton(
                          // color: Colors.pinkAccent,
                          // isFilled: false,
                          text: 'Registrar',
                          onPressed: () {
                            final validForm =
                                registerFormProvider.validateForm();
                            if (!validForm) return;

                            final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            authProvider.register(
                              registerFormProvider.name,
                              registerFormProvider.lastName,
                              registerFormProvider.email,
                              registerFormProvider.password,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Labels(
                          pregunta: '¿Ya tienes una cuenta?',
                          boton: 'Inicia sesión.',
                          onTap: () => Navigator.pushNamed(
                              context, Flurorouter.loginRoute),
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
