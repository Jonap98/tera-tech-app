import 'package:flutter/material.dart';
import 'package:tera_tech_app/providers/side_menu_provider.dart';
import 'package:tera_tech_app/ui/shared/widgets/navbar_avatar.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 50,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          // Menú hamburguesa
          if (size.width <= 700)
            IconButton(
              icon: const Icon(Icons.menu_outlined),
              onPressed: () => SideMenuProvider.openMenu(),
            ),
          // ...[] Esta desestructuración permite meter más de un widget
          // en la condición if en una lista, como un Row

          const SizedBox(width: 5),

          // Barra de busqueda y notifications son elementos genéricos en
          // dashboards administrativos, no aplican aquí, solo de referencia
          // Barra de busqueda
          // if(size.width > 440) // Ocultar busqueda
          // ConstrainedBox(
          //   constraints: BoxConstraints(maxWidth: 250),
          //   child: SearchText(),
          // ),

          // const Expanded(child: SizedBox()),
          const Spacer(),
          // NotificationIndicator(), positioned->container->stack,icono-circulo-texto
          const Text('Mari Jose, Administrador'),
          const SizedBox(width: 10),
          const NavbarAvatar(),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() =>
      const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
        ),
      ]);
}
