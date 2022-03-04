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
        transitionType: TransitionType.fadeIn);

    router.define(solicitarSoporteRoute,
        handler: DashboardHandlers.solicitarSoporte,
        transitionType: TransitionType.fadeIn);

    // 404
    router.notFoundHandler = NotFoundHandlers.notFound;
  }
}
