import 'package:flutter/material.dart';

class CalculatorEntity {
  static List<Map<String, dynamic>> data = [
    {
      'title': 'Energi Potensial',
      'icon': Icons.energy_savings_leaf,
      'route': '/potential_energy'
    },
    {
      'title': 'Gaya Gesek',
      'icon': Icons.public,
      'route': '/gravitational_force'
    },
    {
      'title': 'Gerak Harmonis Sederhana',
      'icon': Icons.build,
      'route': '/work_done'
    },
    {'title': 'Momentum', 'icon': Icons.flash_on, 'route': '/power'},
    {'title': 'Kinematis', 'icon': Icons.sports_mma, 'route': '/momentum'},
    {'title': 'Listrik', 'icon': Icons.sync, 'route': '/circular_motion'},
  ];
}
