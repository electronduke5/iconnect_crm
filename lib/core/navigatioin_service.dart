import 'package:flutter/cupertino.dart';
import 'package:iconnect_crm/presentation/pages/products_page.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  static PageRoute _getPageRoute({
    required String routeName,
    required Widget viewToShow,
  }) {
    return PageRouteBuilder(pageBuilder: (_, __, ___) => viewToShow);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/products':
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const ProductsPage(),
        );
      default:
        return _getPageRoute(
          routeName: settings.name!,
          viewToShow: const ProductsPage(),
        );
    }
  }
}
