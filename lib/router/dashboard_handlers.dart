// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/providers/auth_provider.dart';
import 'package:tera_tech_app/ui/views/dashboard_view.dart';
import 'package:tera_tech_app/ui/views/login_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return const DashboardView();
      else
        return const LoginView();
    },
  );
}
