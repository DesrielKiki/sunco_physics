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
      'icon': 'assets/lesson/icon/ic_potential_energy.png',
      'route': '/potentialEnergyLesson',
    },
    {
      'title': 'Energi Kinetik',
      'icon': 'assets/lesson/icon/ic_kinetic_energy.png',
      'route': '/kineticEnergyLesson',
    },
    {
      'title': 'Energi Mekanik',
      'icon': 'assets/lesson/icon/ic_mechanical_energy.png',
      'route': '/mechanicalEnergyLesson',
    },
    {
      'title': 'Gaya Gesek',
      'icon': 'assets/lesson/icon/ic_friction.png',
      'route': '/frictionLesson',
    },
    {
      'title': 'Usaha',
      'icon': 'assets/lesson/icon/ic_work.png',
      'route': '/workLesson',
    },
    {
      'title': 'Katrol',
      'icon': 'assets/lesson/icon/ic_pulley.png',
      'route': '/pulleyLesson',
    },
    {
      'title': 'kinematik',
      'icon': 'assets/lesson/icon/ic_kinematic.png',
      'route': '/kinematicLesson',
    },
    {
      'title': 'Gaya Pegas',
      'icon': 'assets/lesson/icon/ic_spring.png',
      'route': '/springLesson',
    },
    {
      'title': 'Vektor',
      'icon': 'assets/lesson/icon/ic_vector.png',
      'route': '/vectorLesson',
    },
  ];
}
