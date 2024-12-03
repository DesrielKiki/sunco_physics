import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator/potential_energy.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list.dart';
import 'package:sunco_physics/presentation/screen/home/home_screen.dart';
import 'package:sunco_physics/presentation/screen/lesson/Lesson_list.dart';
import 'package:sunco_physics/presentation/screen/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String calculatorList = '/calculatorList';
  static const String lessonList = '/lessonList';
  static const String potentialEnergy = '/potential_energy';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case calculatorList:
        return MaterialPageRoute(
          builder: (_) => const CalculatorListScreen(),
        );
      case lessonList:
        return MaterialPageRoute(
          builder: (_) => const LessonListScreen(),
        );
      case potentialEnergy:
        return MaterialPageRoute(
          builder: (_) => const PotentialEnergyCalculatorScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('404: Page Not Found'),
            ),
          ),
        );
    }
  }
}
