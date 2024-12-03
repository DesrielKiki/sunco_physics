import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list.dart';
import 'package:sunco_physics/presentation/screen/home/home_screen.dart';
import 'package:sunco_physics/presentation/screen/lesson/Lesson_list.dart';
import 'package:sunco_physics/presentation/screen/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String calculatorList = '/calculatorList';
  static const String lessonList = '/lessonList';

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
