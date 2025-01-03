import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list/kinetic_energy_calculator._screen.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/friction_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/kinetic_energy_lesson.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list/potential_energy_calculator.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list.dart';
import 'package:sunco_physics/presentation/screen/calculator/calculator_list/work_calculator.dart';
import 'package:sunco_physics/presentation/screen/home/home_screen.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/potential_energy_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/online_lesson/add_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson_list.dart';
import 'package:sunco_physics/presentation/screen/lesson/offline_lesson/lesson/work_lesson.dart';
import 'package:sunco_physics/presentation/screen/lesson/online_lesson/online_lesson_list.dart';
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
  static const String addLesson = '/addLesson';

  /// Calculator List Route

  static const String calculatorList = '/calculatorList';
  static const String potentialEnergyCalculator = '/potentialEnergyCalculator';
  static const String workCalculator = '/workCalculator';
  static const String kineticEnergyCalculator = '/kineticEnergyCalculator';

  /// lesson List Route
  static const String offlineLessonList = '/offlineLessonList';
  static const String onlineLessonList = '/onlineLessonList';
  static const String workLesson = '/workLesson';
  static const String potentialEnergyLesson = '/potentialEnergyLesson';
  static const String kineticEnergyLesson = '/kineticEnergyLesson';
  static const String frictionLesson = '/frictionLesson';

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
      case addLesson:
        return MaterialPageRoute(
          builder: (_) => const AddLessonPage(),
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
      case workCalculator:
        return MaterialPageRoute(
          builder: (_) => const WorkCalculatorScreen(),
        );
      case kineticEnergyCalculator:
        return MaterialPageRoute(
          builder: (_) => const KineticEnergyCalculatorScreen(),
        );

      /**
       * Lesson List Route
       */

      case onlineLessonList:
        return MaterialPageRoute(
          builder: (_) => const OnlineLessonListScreen(),
        );
      case offlineLessonList:
        return MaterialPageRoute(
          builder: (_) => const OfflineLessonListScreen(),
        );
      case workLesson:
        return MaterialPageRoute(
          builder: (_) => const WorkLessonScreen(),
        );
      case potentialEnergyLesson:
        return MaterialPageRoute(
          builder: (_) => const PotentialEnergyLessonScreen(),
        );
      case kineticEnergyLesson:
        return MaterialPageRoute(
          builder: (_) => const KineticEnergyLessonScreen(),
        );
      case frictionLesson:
        return MaterialPageRoute(
          builder: (_) => const FrictionLessonScreen(),
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
