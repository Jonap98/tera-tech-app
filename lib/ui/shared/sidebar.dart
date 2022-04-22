// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/providers/auth_provider.dart';
import 'package:tera_tech_app/providers/side_menu_provider.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/services/local_storage.dart';
import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/ui/shared/widgets/logo.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    final idRol = LocalStorage.prefs.getInt('rol');

    return Container(
      width: 200,
      height: double.infinity,
      // color: Colors.redAccent,
      decoration: buildBoxDecoration(),
      child: Column(
        // physics: const ClampingScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () {
              SideMenuProvider.closeMenu();
              (idRol == 3)
                  ? NavigationService.navigateTo(Flurorouter.dashboardRoute)
                  : NavigationService.navigateTo(
                      Flurorouter.estadosSoporteRoute);
            },
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Logo(),
            ),
          ),
          const SizedBox(height: 50),
          (idRol == 1)
              ? SidebarOption(
                  icon: Icons.home_repair_service_rounded,
                  text: 'Registrar empleado',
                  onTap: () {
                    SideMenuProvider.closeMenu();
                    NavigationService.navigateTo(
                        Flurorouter.registrarEmpleadoRoute);
                  },
                )
              : Container(),
          const SizedBox(height: 10),
          (idRol == 3)
              ? SidebarOption(
                  icon: Icons.home_repair_service_rounded,
                  text: 'Solicitar soporte',
                  onTap: () {
                    SideMenuProvider.closeMenu();
                    NavigationService.navigateTo(
                        Flurorouter.solicitarSoporteRoute);
                  },
                )
              // : Container(),
              // const SizedBox(height: 10),
              : SidebarOption(
                  icon: Icons.list_alt,
                  text: 'Tickets histórico',
                  onTap: () {
                    SideMenuProvider.closeMenu();
                    NavigationService.navigateTo(
                        Flurorouter.historicoDeTicketsRoute);
                  },
                ),
          const Spacer(),
          SidebarOption(
            icon: Icons.list_alt,
            text: 'Cerrar sesión',
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              // SideMenuProvider.closeMenu();
              // NavigationService.navigateTo(Flurorouter.historicoDeTicketsRoute);
            },
          ),
          const SizedBox(height: 30),
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
