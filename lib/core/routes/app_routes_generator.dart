


import '../../../libs.dart';

class AppRouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.product:
        return MaterialPageRoute(builder: (_) => const ProductList());
      case AppRoutes.cartWidget:
        return MaterialPageRoute(builder: (_) => const CartWidget());
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case AppRoutes.checkoutPage:
        return MaterialPageRoute(builder: (_) => const CheckOutPage());

      default:
      // If route not found, navigate to a default error page
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}