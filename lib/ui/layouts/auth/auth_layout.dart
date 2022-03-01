import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tera_tech_app/ui/layouts/auth/widgets/background.dart';
// import 'package:tera_tech_app/ui/layouts/auth/widgets/custom_title.dart';
// import 'package:tera_tech_app/ui/layouts/auth/widgets/links_bar.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Este listview se puede wrapear con un Scrollbar o CupertinoScrollbar
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          (size.width > 1000)
              ? _DesktopBody(child: child)
              : _MobileBody(child: child),
          // // LinksBar - No aplica para este proyecto
          // LinksBar()
        ],
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;
  const _MobileBody({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff0A1E3C),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 20),
            // CustomTitle(),
            Image.asset(
              'Logo.png',
              width: 150,
              height: 150,
            ),
            const Text(
              'Iniciar sesión',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: double.infinity,
              height: 420,
              child: child,
            ),
            // Container(
            //   width: double.infinity,
            //   height: 400,
            //   child: Background(),
            // ),
          ]),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;
  const _DesktopBody({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ignore: sized_box_for_whitespace
    return Container(
      width: size.width,
      height: size.height,
      // color: Colors.redAccent,
      child: Row(
        children: [
          // Background
          const Background(),

          // View Container
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            width: 600,
            height: double.infinity,
            color: const Color(0xff0A1E3C),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CustomTitle(),
                // SizedBox(height: 50),
                // Image.asset(
                //   'Logo.png',
                //   width: 150,
                //   height: 100,
                // ),
                // const Text(
                //   'Iniciar sesión',
                //   style: TextStyle(
                //     fontSize: 40,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
                // const SizedBox(height: 30),
                Expanded(child: child),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
