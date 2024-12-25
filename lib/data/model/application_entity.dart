import 'package:flutter/material.dart';

class ApplicationEntity {
  /// List of calculator data

  static List<Map<String, dynamic>> calculator = [
    {
      'title': 'Energi Potensial',
      'icon': Icons.energy_savings_leaf,
      'route': '/potentialEnergyCalculator',
    },
  ];

  ///list of Lesson data
  static List<Map<String, dynamic>> lesson = [
    {
      'title': 'Usaha',
      'icon': Icons.work,
      'route': '/workLesson',
    },
    {
      'title': 'Energi Potensial',
      'icon': Icons.energy_savings_leaf,
      'route': '/potentialEnergyLesson',
    },
    {
      'title': 'dummy',
      'icon': Icons.disabled_by_default,
      'route': '/default',
    },
    {
      'title': 'dummy',
      'icon': Icons.disabled_by_default,
      'route': '/default',
    },
    {
      'title': 'dummy',
      'icon': Icons.disabled_by_default,
      'route': '/default',
    },
    {
      'title': 'dummy',
      'icon': Icons.disabled_by_default,
      'route': '/default',
    },
    {
      'title': 'dummy',
      'icon': Icons.disabled_by_default,
      'route': '/default',
    },
    {
      'title': 'dummy',
      'icon': Icons.disabled_by_default,
      'route': '/default',
    },
  ];
}
