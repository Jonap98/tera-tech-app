// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:tera_tech_app/providers/auth_provider.dart';
import 'package:tera_tech_app/ui/views/dashboard_view.dart';
import 'package:tera_tech_app/ui/views/estados_solicitudes_view.dart';
import 'package:tera_tech_app/ui/views/historico_de_tickets_view.dart';
import 'package:tera_tech_app/ui/views/login_view.dart';
import 'package:tera_tech_app/ui/views/registrar_empleado_view.dart';
import 'package:tera_tech_app/ui/views/solicitar_soporte_view.dart';
import 'package:tera_tech_app/ui/views/soporte_estado_view.dart';
import 'package:tera_tech_app/ui/views/ticket_view.dart';
import 'package:tera_tech_app/ui/views/white_view.dart';

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

  // Solicitar soporte
  static Handler solicitarSoporte = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return const SolicitarSoporteView();
      else
        return const LoginView();
    },
  );

  // Estados de soporte
  static Handler estadosSoporte = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return const EstadosSolicitudesView();
      else
        return const LoginView();
    },
  );

  // Solicitudes por estado
  static Handler solicitudesEstados = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return const SoporteEstadoView();
      else
        return const LoginView();
    },
  );

  // Ticket de solicutud
  static Handler ticketDeSolicitud = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return const TicketView();
      else
        return const LoginView();
    },
  );

  // Historico de tickets
  static Handler historicoDeTickets = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return const HistoricoDeTicketsView();
      else
        return const LoginView();
    },
  );

  // Registrar empleado
  static Handler registrarEmpleado = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return const RegistrarEmpleadoView();
      else
        return const LoginView();
    },
  );

  // White
  static Handler white = Handler(
    handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);
      if (authProvider.authStatus == AuthStatus.authenticated)
        return const WhiteView();
      else
        return const LoginView();
    },
  );
}
