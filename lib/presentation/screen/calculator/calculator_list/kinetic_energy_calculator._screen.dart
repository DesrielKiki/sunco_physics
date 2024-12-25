import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class KineticEnergyCalculatorScreen extends StatefulWidget {
  const KineticEnergyCalculatorScreen({super.key});

  @override
  State<KineticEnergyCalculatorScreen> createState() =>
      _KineticEnergyCalculatorScreenState();
}

class _KineticEnergyCalculatorScreenState
    extends State<KineticEnergyCalculatorScreen> with TickerProviderStateMixin {
  final TextEditingController _massController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();
  String _result = '';

  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _shadowAnimation;
  late Animation<double> _opacityAnimation;

  void _resetFields() {
    setState(() {
      _massController.clear();
      _speedController.clear();
      _result = '';
    });
  }

  void _calculateKineticEnergy() {
    final double? mass = double.tryParse(_massController.text);
    final double? speed = double.tryParse(_speedController.text);

    if (mass != null && speed != null) {
      final double kineticEnergy = 0.5 * mass * speed * speed;
      setState(() {
        _result = 'Energi Kinetik: ${kineticEnergy.toStringAsFixed(2)} Joule';
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
                'CALCULATOR',
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
                'Kinetic Energy',
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
                    label: 'Mass (m) :',
                    controller: _massController,
                    hint: 'Enter numbers (kg)',
                  ),
                  const SizedBox(height: 10),
                  _buildInputField(
                    label: 'Speed (v) :',
                    controller: _speedController,
                    hint: 'Enter numbers (m/s)',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _resetFields,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 38.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _calculateKineticEnergy,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 38.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: const Text(
                          'Count',
                          style: TextStyle(
                            fontSize: 20,
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
                          'Ek = 1/2 × m × v²',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Energi kinetik adalah energi yang dimiliki oleh benda karena gerakannya.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
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
