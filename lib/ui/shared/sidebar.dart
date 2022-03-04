// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tera_tech_app/providers/side_menu_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/ui/shared/widgets/logo.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      // color: Colors.redAccent,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: const [
          Logo(),
          SizedBox(height: 50),
          SidebarOption(),
          // Opciones del sidebar
          // TextSeparator(text: ''),
          // MenuItem(text: '',icon: Icon, onPressed: (){}) // Crear en shared-widgets
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff092044),
            Color(0xff092043),
          ],
        ),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      );
}

class SidebarOption extends StatelessWidget {
  const SidebarOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home_repair_service_rounded,
              color: Colors.white),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            // dragStartBehavior: DragStartBehavior.start,
            onTap: () {
              SideMenuProvider.closeMenu();
              NavigationService.navigateTo(Flurorouter.solicitarSoporteRoute);
            },
            child: const Text(
              'Solicitar soporte',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
