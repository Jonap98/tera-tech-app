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
        children: [
          GestureDetector(
            onTap: () {
              SideMenuProvider.closeMenu();
              NavigationService.navigateTo(Flurorouter.dashboardRoute);
            },
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Logo(),
            ),
          ),
          const SizedBox(height: 50),
          SidebarOption(
            icon: Icons.home_repair_service_rounded,
            text: 'Solicitar soporte',
            onTap: () {
              SideMenuProvider.closeMenu();
              NavigationService.navigateTo(Flurorouter.solicitarSoporteRoute);
            },
          ),
          const SizedBox(height: 10),
          SidebarOption(
            icon: Icons.list_alt,
            text: 'Tickets histórico',
            onTap: () {
              SideMenuProvider.closeMenu();
              NavigationService.navigateTo(Flurorouter.historicoDeTicketsRoute);
            },
          ),
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
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const SidebarOption({
    required this.icon,
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 5),
            // IconButton(
            //   onPressed: () {},
            //   icon: const
            //       color: Colors.white),
            // ),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
