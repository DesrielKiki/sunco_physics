import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/component/output_calculator.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class FrictionForceCalculatorScreen extends StatefulWidget {
  const FrictionForceCalculatorScreen({super.key});

  @override
  State<FrictionForceCalculatorScreen> createState() =>
      _FrictionForceCalculatorScreenState();
}

class _FrictionForceCalculatorScreenState
    extends State<FrictionForceCalculatorScreen> with TickerProviderStateMixin {
  final TextEditingController _normalForceController = TextEditingController();
  final TextEditingController _coefficientController = TextEditingController();
  bool isStaticFriction = true; // Default: Static Friction

  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _shadowAnimation;
  late Animation<double> _opacityAnimation;

  String? _known;
  String? _asked;
  String? _answer;
  String? _conclusion;

  void _resetFields() {
    setState(() {
      _normalForceController.clear();
      _coefficientController.clear();
      _known = null;
      _asked = null;
      _answer = null;
      _conclusion = null;
    });
  }

  void _calculateFrictionForce() {
    final double? normalForce = double.tryParse(_normalForceController.text);
    final double? coefficient = double.tryParse(_coefficientController.text);

    if (normalForce != null && coefficient != null) {
      final double frictionForce = coefficient * normalForce;
      setState(
        () {
          _known =
              "Gaya sNormal (N) = $normalForce\nKoefisien gesek${isStaticFriction ? ' µₛ' : ' µₖ'} = $coefficient";
          _asked = isStaticFriction ? 'µₛ = . . . ?' : 'µₖ = . . . ?';
          _answer =
              '${isStaticFriction ? 'fs' : 'fk'} = ${isStaticFriction ? 'μs' : 'μk'} × N= ${coefficient.toStringAsFixed(2)} × ${normalForce.toStringAsFixed(2)}= ${frictionForce.toStringAsFixed(2)} Newton';
          _conclusion =
              "sehingga gaya gesek ${isStaticFriction ? 'µₛ' : 'µₖ'} adalah $frictionForce Newton";
        },
      );
    } else {
      setState(() {
        _known = null;
        _asked = null;
        _answer = null;
        _conclusion = null;
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
                'Friction Force',
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
                  Center(
                    child: ToggleButtons(
                      isSelected: [isStaticFriction, !isStaticFriction],
                      onPressed: (int index) {
                        setState(() {
                          isStaticFriction = index == 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      selectedColor: Colors.white,
                      fillColor: Colors.blue,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Static',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Kinetic',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildInputField(
                    label: 'Coefficient (${isStaticFriction ? 'µₛ' : 'µₖ'}):',
                    controller: _coefficientController,
                    hint: 'Enter coefficient',
                  ),
                  const SizedBox(height: 10),
                  _buildInputField(
                    label: 'Normal Force (N):',
                    controller: _normalForceController,
                    hint: 'Enter normal force (N)',
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
                        onPressed: _calculateFrictionForce,
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
                    color: Colors.grey.shade300,
                    child: _conclusion != null
                        ? OutputCalculator(
                            known: _known ?? '',
                            asked: _asked ?? '',
                            answer: _answer ?? '',
                            conclusion: _conclusion ?? '',
                          )
                        : const SizedBox(
                            height: 200,
                            width: double.infinity,
                          ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.grey.shade300,
                    child: Column(
                      children: [
                        Text(
                          isStaticFriction ? 'fₛ = µₛ × N' : 'fₖ = µₖ × N',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Gaya gesek adalah resistensi yang terjadi saat dua permukaan saling bersentuhan. Gaya gesek terdiri dari dua jenis, yaitu gaya gesek statis dan gaya gesek kinetis.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, "/potentialEnergyLesson");
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
                  )
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
