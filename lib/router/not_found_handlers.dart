import 'package:fluro/fluro.dart';
import 'package:tera_tech_app/ui/views/not_found_view.dart';

class NotFoundHandlers {
  static Handler notFound = Handler(
    handlerFunc: (context, params) {
      return const NotFoundView();
    },
  );
}
