// main.dart
// main.dart
import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'routes/route_generator.dart';

void main() {
  runApp(const GreenMobilityApp());
}

class GreenMobilityApp extends StatelessWidget {
  const GreenMobilityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green Mobility',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: AppRoutes.otpLogin,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
