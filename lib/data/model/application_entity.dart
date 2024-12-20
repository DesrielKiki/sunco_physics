import 'package:flutter/material.dart';

class ApplicationEntity {
  /// List of calculator data

  static List<Map<String, dynamic>> calculator = [
    {
      'title': 'Energi Potensial',
      'icon': Icons.energy_savings_leaf,
      'route': '/potential_energy_calculator',
    },
    {
      'title': 'Gaya Gesek',
      'icon': Icons.public,
      'route': '/gravitational_force',
    },
    {
      'title': 'Gerak Harmonis Sederhana',
      'icon': Icons.build,
      'route': '/work_done',
    },
    {
      'title': 'Momentum',
      'icon': Icons.flash_on,
      'route': '/power',
    },
    {
      'title': 'Kinematis',
      'icon': Icons.sports_mma,
      'route': '/momentum',
    },
    {
      'title': 'Listrik',
      'icon': Icons.sync,
      'route': '/circular_motion',
    },
  ];

  ///list of Lesson data
  static List<Map<String, dynamic>> lesson = [
    {
      'title': 'Usaha',
      'icon': Icons.work,
      'route': '/work_lesson',
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
    {
      'title': 'dummy',
      'icon': Icons.disabled_by_default,
      'route': '/default',
    },
  ];
}
