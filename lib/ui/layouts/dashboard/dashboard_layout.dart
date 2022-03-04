import 'package:flutter/material.dart';
import 'package:tera_tech_app/providers/side_menu_provider.dart';
import 'package:tera_tech_app/ui/shared/sidebar.dart';
import 'package:tera_tech_app/ui/shared/navbar.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              // Web: Mayor a 700px
              if (size.width >= 700) const Sidebar(),

              Expanded(
                child: Column(
                  children: [
                    // Navbar
                    const Navbar(),
                    // Contenedor del view (pantalla basada en el URL)
                    Expanded(child: widget.child),
                  ],
                ),
              ),
            ],
          ),
          if (size.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context, _) => Stack(
                children: [
                  // Mostrar background negro para hacer click y cerrar el sidebar
                  if (SideMenuProvider.isOpen)
                    Opacity(
                      opacity: SideMenuProvider.opacity.value,
                      child: GestureDetector(
                        onTap: () => SideMenuProvider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  // Otra manera es animatedOpacity
                  // AnimatedOpacity(
                  //   opacity: SideMenuProvider.opacity.value,
                  //   // duration: const Duration(milliseconds: 200),
                  // ),
                  Transform.translate(
                    offset: Offset(SideMenuProvider.movement.value, 0),
                    child: const Sidebar(),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
