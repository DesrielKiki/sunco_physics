import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/screen/home/home_screen.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _navigateWithAnimation(context);
      }
    });
  }

  void _navigateWithAnimation(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Animasi Fade dan Scale
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: ColorConfig.gradientBrand,
        ),
        child: Center(
          child: RotationTransition(
            turns: _controller,
            child: Image.asset('assets/logo_awal.png'),
          ),
        ),
      ),
    );
  }
}
