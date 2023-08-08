import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cart/cart_cubit.dart';
import 'cubit/product/products_cubit.dart';
import 'routes.dart';
import 'screens/product_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsCubit()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: OnGenerateRoute.scaffoldKey,
        navigatorKey: OnGenerateRoute.navigationKey,
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
        onGenerateRoute: OnGenerateRoute.onGenerateRoute,
        home: const ProductScreen(),
      ),
    );
  }
}
