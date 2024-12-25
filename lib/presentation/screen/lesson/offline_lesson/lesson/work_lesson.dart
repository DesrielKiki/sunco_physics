import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/interactive_point.dart';
import 'package:sunco_physics/presentation/component/question_button.dart';
import 'package:sunco_physics/presentation/component/vertical_line_painter.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';
import 'package:sunco_physics/presentation/component/lesson_dialog.dart';

class WorkLessonScreen extends StatefulWidget {
  const WorkLessonScreen({super.key});

  @override
  State<WorkLessonScreen> createState() => _WorkLessonScreenState();
}

class _WorkLessonScreenState extends State<WorkLessonScreen>
    with TickerProviderStateMixin {
  final List<InteractivePoint> points = [
    InteractivePoint(
      position: const Offset(35, 210),
      lineLength: 60,
      title: "Massa",
      description:
          'Massa adalah gaya yang ditimbulkan oleh gravitasi pada sebuah benda. Massa menunjukkan seberapa kuat gravitasi menarik benda tersebut ke bawah. Berat berbeda dari massa, karena berat tidak tergantung pada gravitasi, sedangkan massa iya. Misalnya: Di Bumi, kamu merasa lebih "berat" karena gravitasi Bumi lebih besar. Di Bulan, kamu akan merasa lebih "ringan" karena gravitasi Bulan lebih kecil. Massa biasanya diukur dalam satuan Newton (N), sedangkan berat diukur dalam kilogram (kg)',
    ),
    InteractivePoint(
      position: const Offset(75, 230),
      lineLength: 40,
      title: "Gaya gesek",
      description:
          'Gaya gesek adalah resistensi yang terjadi saat dua permukaan saling bersentuhan. Gaya gesek terdiri dari dua jenis, yaitu gaya gesek statis dan gaya gesek kinetis. Gaya gesek statis adalah gaya gesek yang terjadi saat benda diam, sedangkan gaya gesek kinetis adalah gaya gesek yang terjadi pada benda yang bergerak',
    ),
    InteractivePoint(
      position: const Offset(190, 135),
      lineLength: 135,
      title: "Gaya",
      description:
          'gaya adalah dorongan atau tarikan yang dapat membuat suatu benda bergerak, berubah arah, berhenti, atau berubah bentuk. Contohnya: Ketika kamu mendorong meja, itu adalah gaya dorong. Ketika kamu menarik pintu, itu adalah gaya tarik. Gaya diukur dalam satuan Newton (N)',
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
        title: const Text("Usaha"),
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Apa Itu Usaha?\n\nUsaha (W) adalah energi yang disalurkan gaya kepada suatu benda sehingga benda tersbut bergerak. Satuan usaha ialah Joule. Satuan ini didefinisikan sebagai besarnya energi yang diperlukan untuk memberi gaya sebesar satu Newton dengan jarak sejauh satu meter.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/lesson/img_work.png',
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
                "Untuk menghitung usaha, dapat digunakan rumus berikut:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "W = F × s",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Jika gaya yang diberikan membentuk sudut, maka dapat digunakan rumus berikut:",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "W = F × s × cos(θ)",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Jika gaya yang diberikan kepada benda lebih dari satu, maka cukup hitung usaha untuk setiap gaya lalu jumlahkan usaha tersebut.",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contoh soal usaha : ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 16),
              const QuestionButton(
                title: "Soal 1",
                question:
                    "Sebuah benda didorong oleh dua orang sejauh 5 meter. Orang yang pertama mendorong benda dengan gaya 50 Newton, sedangkan orang yang kedua mendorong dengan gaya 100 Newton. Berapa usahanya?",
                known: "F1 = 50 newton\nF2 = 100 NEWTON\nS = 5 METER",
                asked: "Wtotal = ... ? ",
                answer:
                    "W1 = 50 Newton × 5 meter = 250 Joule\nW2 = 100 Newton × 5 meter = 500 Joule\nWtotal = 250 Joule + 500 Joule = 750 Joule.",
                conclusion:
                    "Sehingga usaha untuk mendorong benda tersebut adalah 750 Joule",
              ),
              const SizedBox(height: 16),
              const QuestionButton(
                title: "Soal 2",
                question:
                    "Sebuah benda ditarik dengan arah 45 derajat dan gaya sebesar 100 Newton sejauh 2 meter. Berapa usahanya?",
                known:
                    "F = 100 Newton\nS = 2 METER\n sudut gaya(θ) = 45 DERAJAT",
                asked: "W = ... ?",
                answer:
                    "W = FxSxcos(θ)\nW = 100 Newton × 2 meter × cos(45) = 141 Joule",
                conclusion:
                    "Sehingga usaha untuk menarik benda tersebut adalah 141 Joule.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
