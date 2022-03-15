// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/api/cafe_api.dart';
import 'package:tera_tech_app/helpers/my_custom_scroll_behavior.dart';
import 'package:tera_tech_app/router/router.dart';
import 'package:tera_tech_app/providers/auth_provider.dart';

import 'package:tera_tech_app/services/navigation_service.dart';
import 'package:tera_tech_app/services/local_storage.dart';

import 'package:tera_tech_app/ui/layouts/auth/auth_layout.dart';
import 'package:tera_tech_app/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:tera_tech_app/ui/layouts/splash/splash_layout.dart';

void main() async {
  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false, // al iniciar la ppa inicia el proceso de autenticación
          create: (_) => AuthProvider(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tera Tech App',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking)
          return const SplashLayout();

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}
