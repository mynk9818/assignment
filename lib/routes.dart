import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screens/cart_screen.dart';
import 'screens/product_screen.dart';
import 'screens/single_product_screen.dart';

sealed class RouteNames {
  static const productScreen = '/productScreen';
  static const cartScreen = '/cartScreen';
  static const singleProduct = '/singleProduct';
}

sealed class OnGenerateRoute {
  static final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  static final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.productScreen:
        return MaterialPageRoute(builder: (context) => const ProductScreen());

      case RouteNames.cartScreen:
        return MaterialPageRoute(builder: (context) => const CartScreen());

      case RouteNames.singleProduct:
        return MaterialPageRoute(
          builder: (context) => SingleProductScreen(
            product: routeSettings.arguments as Product,
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => const ProductScreen());
    }
  }
}
