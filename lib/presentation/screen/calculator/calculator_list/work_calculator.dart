import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class WorkCalculatorScreen extends StatefulWidget {
  const WorkCalculatorScreen({super.key});

  @override
  State<WorkCalculatorScreen> createState() => _WorkCalculatorScreenState();
}

class _WorkCalculatorScreenState extends State<WorkCalculatorScreen>
    with TickerProviderStateMixin {
  final TextEditingController _forceController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _angleController = TextEditingController();
  String _result = '';

  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _shadowAnimation;
  late Animation<double> _opacityAnimation;

  void _resetFields() {
    setState(() {
      _forceController.clear();
      _distanceController.clear();
      _angleController.clear();
      _result = '';
    });
  }

  void _calculateWork() {
    final double? force = double.tryParse(_forceController.text);
    final double? distance = double.tryParse(_distanceController.text);
    final double? angle = double.tryParse(_angleController.text);

    if (force != null && distance != null && angle != null) {
      final double angleInRadians =
          angle * (3.14159 / 180); // Convert to radians
      final double work = force * distance * angleInRadians.abs();
      setState(() {
        _result = 'Usaha: ${work.toStringAsFixed(2)} Joule';
      });
    } else {
      setState(() {
        _result = 'Input tidak valid!';
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = Tween<double>(begin: -200, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _shadowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConfig.darkBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _opacityAnimation,
              child: const Text(
                'KALKULATOR',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
            FadeTransition(
              opacity: _opacityAnimation,
              child: const Text(
                'Usaha',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: _animation.value * 0.4,
                  left: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: ZigzagClipper(),
                    child: Container(
                      height: 47,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: _shadowAnimation.value * 16.0,
                            offset: Offset(0, _shadowAnimation.value * 4),
                            spreadRadius: _shadowAnimation.value * 2.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: ZigzagClipper(),
                      child: Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          color: ColorConfig.darkBlue,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField(
                    label: 'Gaya (F) :',
                    controller: _forceController,
                    hint: 'Masukkan angka (N)',
                  ),
                  const SizedBox(height: 10),
                  _buildInputField(
                    label: 'Jarak (s) :',
                    controller: _distanceController,
                    hint: 'Masukkan angka (m)',
                  ),
                  const SizedBox(height: 10),
                  _buildInputField(
                    label: 'Sudut (θ) :',
                    controller: _angleController,
                    hint: 'Masukkan angka (°)',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _resetFields,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConfig.darkBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 38.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorConfig.onPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _calculateWork,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConfig.darkBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 38.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Hitung',
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorConfig.onPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Text(
                        _result,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.grey.shade300,
                    child: Column(
                      children: [
                        const Text(
                          'W = F × s × cos(θ)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Usaha adalah hasil kali gaya, jarak, dan kosinus sudut di antaranya.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/workLesson");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: const Text('Continue reading the material'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class ZigzagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double zigzagHeight = 20.0;
    const int zigzagCount = 10;

    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - zigzagHeight);

    final double zigzagWidth = size.width / (zigzagCount * 2);

    for (int i = 0; i < zigzagCount; i++) {
      path.lineTo(
        zigzagWidth * (2 * i + 1),
        size.height,
      );
      path.lineTo(
        zigzagWidth * (2 * i + 2),
        size.height - zigzagHeight,
      );
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
