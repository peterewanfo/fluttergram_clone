import 'package:flutter/cupertino.dart';
import 'package:fluttergram_clone/routes/routes.dart';
import 'package:fluttergram_clone/views/home_view/home_view.dart';
import 'package:fluttergram_clone/views/login_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.login_view:
        return CupertinoPageRoute(
          builder: (context) => LoginView(),
        );
        break;
      case Routes.home_view:
        return CupertinoPageRoute(
          builder: (context) => HomeView(),
        );
        break;
      default:
        return CupertinoPageRoute(
          builder: (context) => LoginView(),
        );
        break;
    }
  }
}
