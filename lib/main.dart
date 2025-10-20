import 'package:flutter/material.dart';

import 'locator.dart';
import 'resources/R.dart';
import 'services/routing/placement_routes.dart';
import 'services/auth/auth_service.dart';

void main() async {
  // TODO: Look for more consistent method that prevent race condition when phone is sleeping
  await AuthService().initState();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        primaryColor: R.primaryCol,
        appBarTheme: AppBarTheme(
          backgroundColor: R.primaryCol, 
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: R.primaryCol,
          foregroundColor: Colors.white,
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateColor.resolveWith((states) => R.textColSecondary),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: R.textColSecondary
          )
        )
      ),
      title: 'Placement',
      initialRoute: '/',
      onGenerateRoute: RouteGeneratorPlacement.getRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
