// ignore_for_file: avoid_unnecessary_containers, curly_braces_in_flow_control_structures

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/models/especialidades_model.dart';
import 'package:tera_tech_app/models/roles_model.dart';
import 'package:tera_tech_app/providers/auth_provider.dart';
import 'package:tera_tech_app/providers/recursos_provider.dart';
import 'package:tera_tech_app/providers/register_form_provider.dart';
// import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/notification_service.dart';
import 'package:tera_tech_app/ui/buttons/boton_azul.dart';
import 'package:tera_tech_app/ui/labels/custom_labels.dart';
// import 'package:tera_tech_app/ui/inputs/custom_input.dart';
// import 'package:tera_tech_app/ui/layouts/auth/widgets/labels.dart';

class RegistrarEmpleadoView extends StatelessWidget {
  const RegistrarEmpleadoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChangeNotifierProvider(
        create: (_) => RegisterFormProvider(),
        child: formBuilder(),
      ),
    );
  }

  Builder formBuilder() {
    return Builder(
      builder: (context) {
        final registerFormProvider = Provider.of<RegisterFormProvider>(context);

        return Container(
          // margin: const EdgeInsets.only(top: 30, left: 50, right: 50),
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.all(50),
          //Mío
          // padding: const EdgeInsets.all(30),
          // Fernando
          // margin: const EdgeInsets.only(top: 100),
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          // color: const Color(0xff0A1E3C),
          child: Column(
            children: [
              Text(
                'Registrar técnico',
                style: CustomLabels.h1,
              ),
              const SizedBox(height: 20),
              Center(
                // child: MyForm(),
                // Implementación Fernando Herrera
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: 370, maxHeight: double.infinity),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
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
                            // const SizedBox(height: 10),
                            // const _RolesDropdown(),
                            const SizedBox(height: 10),
                            const _EspecialidadesDropdown(),
                            const SizedBox(height: 10),
                            CustomElevatedButton(
                              // color: Colors.pinkAccent,
                              // isFilled: false,
                              text: 'Registrar',
                              onPressed: () {
                                final validForm =
                                    registerFormProvider.validateForm();
                                if (!validForm) return;

                                // final rol = Provider.of<RecursosProvider>(
                                //         context,
                                //         listen: false)
                                //     .obtenerRolSeleccionado;

                                final especialidad =
                                    Provider.of<RecursosProvider>(context,
                                            listen: false)
                                        .obtenerEspecialidad;

                                // print('Rol: ${rol.nombre}');
                                // print('Especialidad: ${especialidad.nombre}');

                                // if (rol.nombre == '') {
                                //   NotificationService.genericDialog(
                                //       context, 'El rol es obligatorio');
                                // } else if (rol.id == 2 &&
                                if (especialidad.nombre == '') {
                                  NotificationService.genericDialog(context,
                                      'La especialidad es obligatoria');
                                } else {
                                  final pass =
                                      '${registerFormProvider.lastName.substring(0, 3)}${registerFormProvider.name.substring(0, 3)}123.';
                                  // print('Password: $pass');

                                  final authProvider =
                                      Provider.of<AuthProvider>(context,
                                          listen: false);
                                  authProvider.registrarEmpleado(
                                    context,
                                    registerFormProvider.name,
                                    registerFormProvider.lastName,
                                    registerFormProvider.email,
                                    pass,
                                    // rol.id,
                                    2,
                                    especialidad.id,
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            // Labels(
                            //   pregunta: '¿Ya tienes una cuenta?',
                            //   boton: 'Inicia sesión.',
                            //   onTap: () => Navigator.pushNamed(
                            //       context, Flurorouter.loginRoute),
                            // ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
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

class _RolesDropdown extends StatefulWidget {
  // DatoCategoria? selectedValue;

  const _RolesDropdown({
    Key? key,
    // this.selectedValue,
  }) : super(key: key);

  @override
  State<_RolesDropdown> createState() => _RolesDropdownState();
}

class _RolesDropdownState extends State<_RolesDropdown> {
  final opciones = [
    Rol(id: 1, nombre: 'Administrador'),
    Rol(id: 2, nombre: 'Técnico'),
  ];
  Rol? selectedValue;
  // final opciones = [
  //   'Opción 1',
  //   'Opción 2',
  //   'Opción 3',
  //   'Opción 4',
  //   'Opción 5',
  // ];

  @override
  void initState() {
    super.initState();
    // categorias = Provider.of<SolicitudesProvider>(context, listen: false)
    //     .getCategorias();
  }

  @override
  Widget build(BuildContext context) {
    // categorias.asStream().forEach((element) {
    //   opciones.add(element.datos);
    // });

    return DropdownButtonFormField<Rol>(
      hint: const Text('Selecciona un rol'),
      // validator: (value) =>
      //     value == null ? 'Selecciona una catagoría' : null,
      // PAra hacer uso del index se ocupa un itemBuilder con el index
      value: selectedValue,
      // value: (selectedValue != '') ? '' : 'Selecciona una categoría',
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: const Color(0xffEDF1F2),
      ),
      dropdownColor: const Color(0xffEDF1F2),
      icon: const Icon(Icons.arrow_drop_down),
      // items:
      //  snapshot.data!
      //     .map<DropdownMenuItem<DatoCategoria>>((DatoCategoria opcion) {
      //   return DropdownMenuItem(
      //     value: opcion,
      //     child: Text(opcion.nombre),
      //   );
      // }).toList(),
      items: opciones.map<DropdownMenuItem<Rol>>((Rol? opciones) {
        return DropdownMenuItem(
          value: opciones,
          child: Text(opciones!.nombre),
        );
      }).toList(),
      // items: opciones.map((String opciones) {
      //   return DropdownMenuItem(
      //     value: opciones.,
      //     child: Text(opciones),
      //   );
      // }).toList(),
      onChanged: (Rol? newValue) {
        selectedValue = newValue;
        Provider.of<RecursosProvider>(context, listen: false)
            .cargarRol(selectedValue!);
        setState(() {});
      },
      // onChanged: (Rol? newValue) {
      //   selectedValue = newValue!;
      //   // print(selectedValue!.id);
      //   // print(selectedValue!.nombre);
      //   // Provider.of<SolicitudesProvider>(context, listen: false)
      //   //     .cargarSelectedValue(widget.selectedValue!);
      //   setState(() {});
      // },
    );
  }
}

class _EspecialidadesDropdown extends StatefulWidget {
  // DatoCategoria? selectedValue;

  const _EspecialidadesDropdown({
    Key? key,
    // this.selectedValue,
  }) : super(key: key);

  @override
  State<_EspecialidadesDropdown> createState() =>
      _EspecialidadesDropdownState();
}

class _EspecialidadesDropdownState extends State<_EspecialidadesDropdown> {
  final opciones = [
    Especialidad(id: 1, nombre: 'Componentes hardware'),
    Especialidad(id: 2, nombre: 'Equipos Mac'),
    Especialidad(id: 3, nombre: 'Equipos Windows'),
    Especialidad(id: 4, nombre: 'Equipos Android'),
    Especialidad(id: 5, nombre: 'Equipos iPhone'),
  ];
  Especialidad? selectedValue;
  // final opciones = [
  //   'Opción 1',
  //   'Opción 2',
  //   'Opción 3',
  //   'Opción 4',
  //   'Opción 5',
  // ];

  @override
  void initState() {
    super.initState();
    // categorias = Provider.of<SolicitudesProvider>(context, listen: false)
    //     .getCategorias();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<RecursosProvider>(context, listen: false).eliminarRecursos();
    });
  }

  @override
  Widget build(BuildContext context) {
    // categorias.asStream().forEach((element) {
    //   opciones.add(element.datos);
    // });

    return DropdownButtonFormField<Especialidad>(
      hint: const Text('Selecciona una especialidad'),
      // validator: (value) =>
      //     value == null ? 'Selecciona una catagoría' : null,
      // PAra hacer uso del index se ocupa un itemBuilder con el index
      value: selectedValue,
      // value: (selectedValue != '') ? '' : 'Selecciona una categoría',
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEDF1F2), width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: const Color(0xffEDF1F2),
      ),
      dropdownColor: const Color(0xffEDF1F2),
      icon: const Icon(Icons.arrow_drop_down),
      // items:
      //  snapshot.data!
      //     .map<DropdownMenuItem<DatoCategoria>>((DatoCategoria opcion) {
      //   return DropdownMenuItem(
      //     value: opcion,
      //     child: Text(opcion.nombre),
      //   );
      // }).toList(),
      items: opciones
          .map<DropdownMenuItem<Especialidad>>((Especialidad? opciones) {
        return DropdownMenuItem(
          value: opciones,
          child: Text(opciones!.nombre),
        );
      }).toList(),
      // items: opciones.map((String opciones) {
      //   return DropdownMenuItem(
      //     value: opciones.,
      //     child: Text(opciones),
      //   );
      // }).toList(),
      onChanged: (Especialidad? newValue) {
        selectedValue = newValue;
        Provider.of<RecursosProvider>(context, listen: false)
            .cargarEspecialidad(selectedValue!);
        setState(() {});
      },
      // onChanged: (Rol? newValue) {
      //   selectedValue = newValue!;
      //   // print(selectedValue!.id);
      //   // print(selectedValue!.nombre);
      //   // Provider.of<SolicitudesProvider>(context, listen: false)
      //   //     .cargarSelectedValue(widget.selectedValue!);
      //   setState(() {});
      // },
    );
  }
}
