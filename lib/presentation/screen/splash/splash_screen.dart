import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunco_physics/presentation/navigation/home_navigation.dart';
import 'package:sunco_physics/presentation/screen/auth/login/login_screen.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _logoMovementAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<int> _textTypingAnimation;

  final String _text = 'SUNCO PHYSICS!';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkLoginStatus();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 850),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _logoMovementAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -64),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2750),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _textTypingAnimation = IntTween(begin: 0, end: _text.length).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeOut),
    );

    _controller.forward().then((_) {
      _rotationController.repeat();
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');

    // Tunggu animasi selesai sebelum melakukan navigasi
    await Future.delayed(const Duration(seconds: 5));

    if (mounted) {
      if (isLoggedIn == true) {
        _navigateTo(const HomeNavigationPage());
      } else {
        _navigateTo(const LoginScreen());
      }
    }
  }

  void _navigateTo(Widget targetPage) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) => targetPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
    _rotationController.dispose();
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: _logoMovementAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: RotationTransition(
                        turns: _rotationAnimation,
                        child: child,
                      ),
                    ),
                  );
                },
                child: Image.asset('assets/logo_awal.png'),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  if (_controller.isCompleted) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 92),
                          AnimatedBuilder(
                            animation: _textTypingAnimation,
                            builder: (context, child) {
                              String textToShow = _text.substring(
                                  0, _textTypingAnimation.value);
                              return Text(
                                textToShow,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
