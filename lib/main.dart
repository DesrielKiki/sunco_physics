import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sunco_physics/firebase_options.dart';
import 'package:sunco_physics/presentation/navigation/app_routes.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list/friction_force_calculator.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list/kinetic_energy_calculator._screen.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/kinematic_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/kinetic_energy_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/mechanical_energy_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/potential_energy_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/spring_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/vector_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      title: 'Flutter Demo',
      // debugShowCheckedModeBanner: false,
      // initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const KineticEnergyCalculatorScreen(),
    );
  }
}
