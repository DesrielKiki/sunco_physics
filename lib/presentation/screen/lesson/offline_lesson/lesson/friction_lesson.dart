import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/interactive_point.dart';
import 'package:sunco_physics/presentation/component/formula_text.dart';
import 'package:sunco_physics/presentation/component/lesson_dialog.dart';
import 'package:sunco_physics/presentation/component/question_button.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/component/vertical_line_painter.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class FrictionLessonScreen extends StatefulWidget {
  const FrictionLessonScreen({super.key});

  @override
  State<FrictionLessonScreen> createState() => _FrictionLessonScreenState();
}

class _FrictionLessonScreenState extends State<FrictionLessonScreen>
    with TickerProviderStateMixin {
  final List<InteractivePoint> points = [
    InteractivePoint(
        position: const Offset(150, 195),
        lineLength: 65,
        title: "Gaya Gesek",
        description:
            'Gaya gesek adalah resistensi yang terjadi saat dua permukaan saling bersentuhan. Gaya gesek terdiri dari dua jenis, yaitu gaya gesek statis dan gaya gesek kinetis. Gaya gesek statis adalah gaya gesek yang terjadi saat benda diam, sedangkan gaya ges'),
    InteractivePoint(
        position: const Offset(200, 125),
        lineLength: 135,
        title: "Koefisien Gaya Gesek",
        description: ''),
  ];

  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _opacityAnimations;
  late List<bool> clickedPoints;
  late List<double> opacityValues;

  @override
  void initState() {
    super.initState();

    clickedPoints = List.generate(points.length, (_) => false);
    opacityValues = List.generate(points.length, (_) => 1.0);

    _animationControllers = List.generate(
      points.length,
      (_) => AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      )..repeat(reverse: true),
    );

    _opacityAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(begin: 1.0, end: 0.5).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          ),
        )
        .toList();

    debugPrint('Initial opacityValues: $opacityValues');
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showDescription(String description, String title) {
    debugPrint("Menampilkan deskripsi: $description");
    showDialog(
      context: context,
      builder: (context) => LessonDialog(
        description: description,
        title: title,
      ),
    );
  }

  void _onPointClicked(int index) {
    if (!clickedPoints[index]) {
      setState(() {
        opacityValues[index] = 1.0;
        clickedPoints[index] = true;
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        _animationControllers[index].stop();

        _showDescription(points[index].description, points[index].title);
      });
    } else {
      _showDescription(points[index].description, points[index].title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gaya Gesek'),
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SubtitleWithDescription(
                subtitle: "Apa itu gaya gesek ?",
                description:
                    "Gaya gesek adalah resistensi yang terjadi saat dua permukaan saling bersentuhan. Gaya gesek terdiri dari dua jenis, yaitu gaya gesek statis dan gaya gesek kinetis. Gaya gesek statis adalah gaya gesek yang terjadi saat benda diam, sedangkan gaya gesek kinetis adalah gaya gesek yang terjadi pada benda yang bergerak",
              ),
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/lesson/img_gaya_gesek.png',
                      width: 400,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: Listenable.merge(_animationControllers),
                        builder: (context, child) {
                          return CustomPaint(
                            painter: VerticalLinePainter(
                              points: points,
                              opacityValues: _opacityAnimations
                                  .map((anim) => anim.value)
                                  .toList(),
                            ),
                          );
                        },
                      ),
                    ),
                    ...points.asMap().map((index, point) {
                      final Offset endPosition = Offset(
                        point.position.dx,
                        point.position.dy + point.lineLength,
                      );

                      return MapEntry(
                        index,
                        Positioned(
                          left: endPosition.dx - 10,
                          top: endPosition.dy - 0,
                          child: FadeTransition(
                            opacity: _opacityAnimations[index],
                            child: GestureDetector(
                              onTap: () {
                                _onPointClicked(index);
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).values
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Rumus Untuk menghitung gaya gesek adalah statis dan kinetis adalah sebagai berikut : ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gaya gesek statis (fs)",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const FormulaText(
                formula: "fs = μs × N",
                description:
                    "- μs = Koefisien gesekan statis\n- N = Gaya normal (Newton)",
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gaya gesek kinetis (fk)",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const FormulaText(
                formula: "fk = μk × N",
                description:
                    "- μk = Koefisien gesekan kinetik \n- N = Gaya normal (Newton)",
              ),
              const SizedBox(height: 16),
              const Text(
                "Koefisien gesekan adalah nilai kekasaran permukaan material benda.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Sementara rumus untuk menghitung Gaya Normal adalah sebagai berikut:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gaya berat (w)",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const FormulaText(
                formula: "w = m x g",
                description:
                    "- w = Berat (N)\n- m = Massa (kg)\n- g = Percepatan gravitasi (10 m/s²)",
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gaya Normal (N) pada bidang datar",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const FormulaText(
                formula: "N = w = m × g",
                description:
                    "- N = Gaya normal (Newton)\n- w = Berat (N)\n- m = Massa (kg)\n- g = Percepatan gravitasi (10 m/s²)",
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gaya Normal (N) pada bidang miring",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const FormulaText(
                formula: "N = w × cos(α) = m × g × cos(α)",
                description:
                    "- N = Gaya normal (Newton)\n- w = Berat (N)\n- m = Massa (kg)\n- g = Percepatan gravitasi (10 m/s²)\n- α = Sudut kemiringan bidang",
              ),
              const SizedBox(height: 16),
              const QuestionButton(
                title: "Soal gaya gesek",
                question:
                    "Sebuah kayu dengan berat 5 kg diletakkan di atas permukaan logam yang datar. Hitunglah gaya gesek statis yang terjadi antara kayu dengan permukaan logam jika diketahui koefisien gesek statisnya = 0.3!",
                answer:
                    "- fs = μs ×\n- fs = μs × m × g\n- fs = 0.3 × 5 × 10\n- fs = 15 Newton",
                known: "- m = 5 kg\n- g = 10 m/detik\n- μs = 0.3",
                asked: "Gaya gesek statis (fs) = ... ? ",
                conclusion:
                    "Sehingga gaya gesek antara kayu dan logam tersebut adalah 15 Newton.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
