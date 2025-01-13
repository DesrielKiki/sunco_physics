import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/interactive_point.dart';
import 'package:sunco_physics/presentation/component/formula_text.dart';
import 'package:sunco_physics/presentation/component/lesson_dialog.dart';
import 'package:sunco_physics/presentation/component/question_button.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/component/vertical_line_painter.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class KineticEnergyLessonScreen extends StatefulWidget {
  const KineticEnergyLessonScreen({super.key});

  @override
  State<KineticEnergyLessonScreen> createState() =>
      _KineticEnergyLessonScreenState();
}

class _KineticEnergyLessonScreenState extends State<KineticEnergyLessonScreen>
    with TickerProviderStateMixin {
  final List<InteractivePoint> points = [
    InteractivePoint(
      position: const Offset(215, 188),
      lineLength: 127,
      title: "Massa",
      description:
          'Massa adalah gaya yang ditimbulkan oleh gravitasi pada sebuah benda. Massa menunjukkan seberapa kuat gravitasi menarik benda tersebut ke bawah. Berat berbeda dari massa, karena berat tidak tergantung pada gravitasi, sedangkan massa iya. Misalnya: Di Bumi, kamu merasa lebih "berat" karena gravitasi Bumi lebih besar. Di Bulan, kamu akan merasa lebih "ringan" karena gravitasi Bulan lebih kecil. Massa biasanya diukur dalam satuan Newton (N), sedangkan berat diukur dalam kilogram (kg)',
    ),
    InteractivePoint(
      position: const Offset(275, 188),
      lineLength: 127,
      title: "kecepatan",
      description:
          'Kecepatan adalah seberapa cepat sesuatu bergerak dan ke mana arah geraknya. Jadi, kecepatan bukan hanya tentang "seberapa cepat," tapi juga "arahnya." Contohnya, jika naik sepeda ke utara dengan kecepatan 10 km/jam, itu berarti kecepatanmu adalah 10 km/jam ke utara',
    ),
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
        title: const Text("Energi Kinetik"),
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SubtitleWithDescription(
                subtitle: "Energi Kinetik",
                description:
                    "Energi kinetik adalah energi yang dimiliki oleh suatu benda karena gerak yang dilakukan atau dialaminya. Semua benda yang bergerak memiliki energi kinetik. Energi kinetik dipengaruhi oleh massa dan kecepatan suatu benda saat bergerak. Contoh energi kinetik adalah ketika sebuah batu dilempar. Batu yang dilempar tersebut akan melaju dengan kecepatan tertentu, yang menyebabkannya memiliki energi. Energinya dapat lihat ketika batu ini menabrak sasaran yang dikenainya",
              ),
              const SizedBox(height: 16),
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/lesson/img_energi_kinetik.png',
                      width: 400,
                      height: 350,
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
                "Rumus untuk menghitung energi kinetik adalah : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const FormulaText(
                  formula: "Ek = 1/2 x m x v²",
                  description:
                      "- Ek = Energi kinetik (Joule)\n- m = Massa benda (kg)\n- v = kecepatan (m/detik)"),
              const SizedBox(height: 16),
              const QuestionButton(
                title: "Soal 1",
                question:
                    "Sebuah mobil sedan yang memiliki massa 500 kg sedang melaju dengan kecepatan 25 m/s. Hitunglah energi kinetik mobil pada kelajuan tersebut!",
                known: "M = 500 kg\nv = 25 m/s",
                asked: "Ek = ... ? ",
                answer:
                    "Ek = 1/2 x m x v²\nEk = 1/2 x 500 x 25²\nEk = 156.250 Joule",
                conclusion:
                    "Sehingga Energi kinetik mobil tersebut adalah 156.250 Joule.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
