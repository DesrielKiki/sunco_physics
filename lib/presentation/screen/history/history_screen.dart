import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 192,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: ColorConfig.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(87),
              bottomRight: Radius.circular(87),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15.0,
                offset: Offset(0, 6),
                spreadRadius: 4.0,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
