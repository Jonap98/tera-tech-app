import 'package:fluro/fluro.dart';
import 'package:tera_tech_app/router/admin_handlers.dart';
import 'package:tera_tech_app/router/dashboard_handlers.dart';
import 'package:tera_tech_app/router/not_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();
  // static final FluroRouter router = new FluroRouter();

  static String rootRoute = '/';

  // Auth routes
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  // Dashboard
  static String dashboardRoute = '/dashboard';
  // Solicitar soporte
  static String solicitarSoporteRoute = '/solicitar-soporte';
  // Estados soporte
  static String estadosSoporteRoute = '/estados-soporte';
  // Solicitudes por estado
  static String solicitudesEstadosRoute = '/solicitudes-estado';
  // Ticket de soporte
  static String ticketDeSolicitudRoute = '/ticket-de-solicitud';
  // Historico de tickets
  static String historicoDeTicketsRoute = '/historico-de-tickets';
  // White
  static String whiteRoute = '/white';

  static configureRoutes() {
    // Auth routes

    // Root
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    // Login
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    // Registro
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);

    // Dashboard routes

    // Dashboard
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.none);
    // transitionType: TransitionType.fadeIn);

    // Solicitar soporte
    router.define(solicitarSoporteRoute,
        handler: DashboardHandlers.solicitarSoporte,
        transitionType: TransitionType.none);

    // Estados soporte
    router.define(estadosSoporteRoute,
        handler: DashboardHandlers.estadosSoporte,
        transitionType: TransitionType.none);

    // Solicitudes por estado
    router.define(solicitudesEstadosRoute,
        handler: DashboardHandlers.solicitudesEstados,
        transitionType: TransitionType.none);

    // Ticket de solicitud
    router.define(ticketDeSolicitudRoute,
        handler: DashboardHandlers.ticketDeSolicitud,
        transitionType: TransitionType.none);

    // Historico de tickets route
    router.define(
      historicoDeTicketsRoute,
      handler: DashboardHandlers.historicoDeTickets,
      transitionType: TransitionType.none,
    );

    // White
    router.define(
      whiteRoute,
      handler: DashboardHandlers.white,
      transitionType: TransitionType.none,
    );

    // 404
    router.notFoundHandler = NotFoundHandlers.notFound;
  }
}
