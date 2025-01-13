import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/component/output_calculator.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class WorkCalculatorScreen extends StatefulWidget {
  const WorkCalculatorScreen({super.key});

  @override
  State<WorkCalculatorScreen> createState() => _WorkCalculatorScreenState();
}

class _WorkCalculatorScreenState extends State<WorkCalculatorScreen>
    with TickerProviderStateMixin {
  int _numberOfForces = 1;

  final List<TextEditingController> _forceControllers = [];
  final List<TextEditingController> _angleControllers = [];
  final TextEditingController _distanceController = TextEditingController();

  String _known = '';
  String _asked = '';
  String _answer = '';
  String _conclusion = '';

  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _shadowAnimation;
  late Animation<double> _opacityAnimation;

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

    _updateForceControllers();
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in _forceControllers) {
      controller.dispose();
    }
    for (var controller in _angleControllers) {
      controller.dispose();
    }
    _distanceController.dispose();
    super.dispose();
  }

  void _updateForceControllers() {
    setState(() {
      while (_forceControllers.length < _numberOfForces) {
        _forceControllers.add(TextEditingController());
        _angleControllers.add(TextEditingController());
      }
      while (_forceControllers.length > _numberOfForces) {
        _forceControllers.removeLast().dispose();
        _angleControllers.removeLast().dispose();
      }
    });
  }

  void _resetFields() {
    setState(() {
      for (var controller in _forceControllers) {
        controller.clear();
      }
      for (var controller in _angleControllers) {
        controller.clear();
      }
      _distanceController.clear();
      _known = '';
      _asked = '';
      _answer = '';
      _conclusion = '';
    });
  }

  void _calculateWork() {
    final double? distance = double.tryParse(_distanceController.text);
    if (distance == null || distance <= 0) {
      _showErrorDialog('Masukkan jarak (s) yang valid (lebih dari 0).');
      return;
    }

    for (int i = 0; i < _numberOfForces; i++) {
      final double? force = double.tryParse(_forceControllers[i].text);
      final double? angle = double.tryParse(_angleControllers[i].text);

      if (force == null || force <= 0) {
        _showErrorDialog(
            'Masukkan gaya (F${i + 1}) yang valid (lebih dari 0).');
        return;
      }
      if (angle == null || angle < 0 || angle > 360) {
        _showErrorDialog('Masukkan sudut (θ${i + 1}) yang valid (0° - 360°).');
        return;
      }
    }

    double totalWork = 0;
    String knownDetails = '';
    String calculationSteps = '';
    String totalCalculationSteps = '';

    for (int i = 0; i < _numberOfForces; i++) {
      final double force = double.parse(_forceControllers[i].text);
      final double angle = double.parse(_angleControllers[i].text);

      final double angleInRadians = angle * (pi / 180);
      final double work = force * distance * cos(angleInRadians);
      totalWork += work;

      knownDetails += 'Gaya F${i + 1} = $force N, Sudut θ${i + 1} = $angle°\n';
      calculationSteps +=
          'W${i + 1} = F${i + 1} × s × cos(θ${i + 1})\n   = $force × $distance × cos($angle°)\n   = ${work.toStringAsFixed(2)} Joule\n\n';

      totalCalculationSteps +=
          i == 0 ? work.toStringAsFixed(2) : ' + ${work.toStringAsFixed(2)}';
    }

    totalCalculationSteps += ' = ${totalWork.toStringAsFixed(2)} Joule';

    setState(() {
      _known = 'Jarak (s) = $distance m\n$knownDetails';
      _asked = 'Berapa besar usaha (W)?';
      _answer =
          'Langkah Perhitungan:\n$calculationSteps Total Usaha:\nW = Σ(W1 + W2 + ... + Wn)\n   = $totalCalculationSteps';
      _conclusion =
          'Usaha yang dilakukan adalah ${totalWork.toStringAsFixed(2)} Joule.';
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Input Tidak Valid'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButton<int>(
                    isExpanded: true,
                    value: _numberOfForces,
                    menuWidth: double.infinity,
                    items: List.generate(
                      4,
                      (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text('${index + 1} Gaya'),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _numberOfForces = value;
                          _updateForceControllers();
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(_numberOfForces, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputField(
                          label: 'Gaya F${index + 1} (N):',
                          controller: _forceControllers[index],
                          hint: 'Masukkan gaya (N)',
                        ),
                        const SizedBox(height: 10),
                        _buildInputField(
                          label: 'Sudut θ${index + 1} (°):',
                          controller: _angleControllers[index],
                          hint: 'Masukkan sudut (°)',
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }),
                  _buildInputField(
                    label: 'Jarak (s) :',
                    controller: _distanceController,
                    hint: 'Masukkan jarak (m)',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _resetFields,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConfig.redWarning,
                          foregroundColor: ColorConfig.onPrimaryColor,
                        ),
                        child: const Text('Reset'),
                      ),
                      ElevatedButton(
                        onPressed: _calculateWork,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConfig.green,
                          foregroundColor: ColorConfig.onPrimaryColor,
                        ),
                        child: const Text('Hitung'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: _conclusion.isNotEmpty
                        ? OutputCalculator(
                            known: _known,
                            asked: _asked,
                            answer: _answer,
                            conclusion: _conclusion,
                          )
                        : const SizedBox(
                            height: 200,
                            width: double.infinity,
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
        Text(label),
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
