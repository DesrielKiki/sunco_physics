import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/navigation/app_routes.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator/potential_energy.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const CalculatorListScreen(),
    );
  }
}
