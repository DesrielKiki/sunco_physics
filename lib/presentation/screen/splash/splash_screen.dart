import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/screen/home/home_screen.dart';
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

  final String _text = 'SUNCO PHYSICS!'; // Teks yang ingin ditampilkan

  @override
  void initState() {
    super.initState();

    // AnimationController utama untuk logo scale dan movement
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Animasi untuk memperbesar logo dan pergerakan ke atas
    _scaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Gerakan logo lebih jelas naik ke atas saat membesar
    _logoMovementAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(
          0, -64), // Menambah nilai pergerakan ke atas (nilai lebih besar)
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // AnimationController untuk animasi rotasi
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animasi rotasi
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // Animasi mengetik
    _textTypingAnimation = IntTween(begin: 0, end: _text.length).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeOut),
    );

    // Mulai animasi pembesaran dan pergerakan logo
    _controller.forward().then((_) {
      // Setelah logo selesai membesar dan bergerak, mulai animasi rotasi
      _rotationController.forward();
    });

    // Setelah animasi selesai, navigasi ke halaman berikutnya
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
              // Logo dengan animasi membesar dan sedikit naik
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

              // Menambahkan posisi teks setelah logo selesai membesar
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  // Pastikan teks muncul setelah logo selesai membesar
                  if (_controller.isCompleted) {
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                              height: 92), // Menyesuaikan jarak dengan logo
                          // Teks yang muncul dengan efek mengetik
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
                    return const SizedBox
                        .shrink(); // Tidak tampilkan teks selama animasi
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
