import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list/potential_energy.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list.dart';
import 'package:sunco_physics/presentation/screen/home/home_screen.dart';
import 'package:sunco_physics/presentation/screen/lesson/lesson_list.dart';
import 'package:sunco_physics/presentation/screen/lesson/list/work_lesson.dart';
import 'package:sunco_physics/presentation/screen/profile/edit/edit_password.dart';
import 'package:sunco_physics/presentation/screen/profile/edit/edit_profile.dart';
import 'package:sunco_physics/presentation/screen/splash/splash_screen.dart';

class AppRoutes {
  /// Main List Route

  static const String splash = '/';
  static const String home = '/home';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String editProfile = '/edit_profile';
  static const String editPassword = '/edit_password';

  /// Calculator List Route

  static const String calculatorList = '/calculatorList';
  static const String potentialEnergyCalculator =
      '/potential_energy_calculator';

  /// lesson List Route
  static const String lessonList = '/lessonList';
  static const String workLesson = '/work_lesson';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /**
       * Main List Route
       */

      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case editProfile:
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );
      case editPassword:
        return MaterialPageRoute(
          builder: (_) => const EditPasswordScreen(),
        );

      /**
       * Calculator List Route
       */

      case calculatorList:
        return MaterialPageRoute(
          builder: (_) => const CalculatorListScreen(),
        );
      case potentialEnergyCalculator:
        return MaterialPageRoute(
          builder: (_) => const PotentialEnergyCalculatorScreen(),
        );

      /**
       * Lesson List Route
       */

      case lessonList:
        return MaterialPageRoute(
          builder: (_) => const LessonListScreen(),
        );
      case workLesson:
        return MaterialPageRoute(
          builder: (_) => const WorkLessonScreen(),
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
