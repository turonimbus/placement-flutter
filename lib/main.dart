import 'package:flutter/material.dart';
import 'package:placement/locator.dart';
import 'package:placement/resources/R.dart';
import 'package:placement/services/routing/placement_routes.dart';

void main() {
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
          fillColor: WidgetStateColor.resolveWith((states) => R.primaryCol),
        ),
      ),
      title: 'Placement',
      initialRoute: '/',
      onGenerateRoute: RouteGeneratorPlacement.getRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
