import 'package:flutter/material.dart';

class ApplicationEntity {
  /// List of calculator data

  static List<Map<String, dynamic>> calculator = [
    {
      'title': 'Energi Potensial',
      'icon': Icons.energy_savings_leaf,
      'route': '/potentialEnergyCalculator',
    },
    {
      'title': 'Usaha',
      'icon': Icons.work,
      'route': '/workCalculator',
    },
    {
      'title': 'Energi Kinetik',
      'icon': Icons.work,
      'route': '/kineticEnergyCalculator',
    },
  ];

  ///list of Lesson data
  static List<Map<String, dynamic>> lesson = [
    {
      'title': 'Energi Potensial',
      'icon': Icons.energy_savings_leaf,
      'route': '/potentialEnergyLesson',
    },
    {
      'title': 'Energi Kinetik',
      'icon': Icons.energy_savings_leaf,
      'route': '/kineticEnergyLesson',
    },
    {
      'title': 'Gaya Gesek',
      'icon': Icons.work,
      'route': '/frictionLesson',
    },
    {
      'title': 'Usaha',
      'icon': Icons.work,
      'route': '/workLesson',
    },
    //energi mekanik
    {
      'title': 'Katrol',
      'icon': Icons.turn_sharp_right_outlined,
      'route': '/pulleyLesson',
    },
    //?
    {
      'title': 'Gaya Pegas',
      'icon': Icons.turn_sharp_right_outlined,
      'route': '/springLesson',
    },

    // static const String potentialEnergyLesson = '/potentialEnergyLesson';
    // static const String kineticEnergyLesson = '/kineticEnergyLesson';
    //     static const String workLesson = '/workLesson';
    // static const String pulleyLesson = '/pulleyLesson';
    // static const String frictionLesson = '/frictionLesson';
    // static const String springLesson = '/springLesson';
  ];
}
