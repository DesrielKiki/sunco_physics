import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/interactive_point.dart';
import 'package:sunco_physics/presentation/component/formula_text.dart';
import 'package:sunco_physics/presentation/component/horizontal_line_painter.dart';
import 'package:sunco_physics/presentation/component/lesson_dialog.dart';
import 'package:sunco_physics/presentation/component/question_button.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class PulleyLessonScreen extends StatefulWidget {
  const PulleyLessonScreen({super.key});

  @override
  State<PulleyLessonScreen> createState() => _PulleyLessonScreenState();
}

class _PulleyLessonScreenState extends State<PulleyLessonScreen>
    with TickerProviderStateMixin {
  final List<InteractivePoint> points = [
    InteractivePoint(
      position: const Offset(150, 100),
      lineLength: 200,
      title: "Tegangan Tali",
      description:
          'Tegangan tali adalah gaya yang bekerja pada tali ketika tali tersebut menarik atau menahan suatu benda. Tegangan ini terjadi karena tali mentransfer gaya dari satu benda ke benda lain. Misalnya, ketika menarik sebuah ember dengan tali, gaya yang diberikan diteruskan melalui tegangan tali ke ember. Tegangan selalu bekerja sepanjang arah tali dan biasanya dianggap seragam jika tali tidak elastis dan ringan.',
    ),
    InteractivePoint(
      position: const Offset(225, 190),
      lineLength: 125,
      title: "Gaya Tarik",
      description:
          'Gaya tarik adalah gaya yang diberikan untuk menarik suatu benda ke arah tertentu. Misalnya, gaya ini terjadi saat seseorang menarik tali, membuka pintu, atau menarik gerobak. Gaya tarik bekerja untuk menggerakkan benda mendekat ke arah sumber gaya dan dapat dihasilkan oleh berbagai hal, seperti tangan, mesin, atau alat lainnya.',
    ),
    InteractivePoint(
      position: const Offset(150, 280),
      lineLength: 200,
      title: "Massa",
      description:
          'Massa adalah gaya yang ditimbulkan oleh gravitasi pada sebuah benda. Massa menunjukkan seberapa kuat gravitasi menarik benda tersebut ke bawah. Berat berbeda dari massa, karena berat tidak tergantung pada gravitasi, sedangkan massa iya. Misalnya: Di Bumi, kamu merasa lebih "berat" karena gravitasi Bumi lebih besar. Di Bulan, kamu akan merasa lebih "ringan" karena gravitasi Bulan lebih kecil. Massa biasanya diukur dalam satuan Newton (N), sedangkan berat diukur dalam kilogram (kg)',
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
        title: const Text('Katrol'),
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SubtitleWithDescription(
                subtitle: 'Apa itu katrol?',
                description:
                    'Katrol adalah roda yang berputar pada porosnya dan dilewati sebuah rantai ataupun tali. Katrol pada dasarnya sama dengan tuas dan dapat mengangkat benda-benda yang lebih berat dari kemampuan. Sementara katrol tetap adalah katrol yang porosnya tidak berpindah-pindah. Keuntungan mekanik dari katrol tetap adalah 1. Itu berarti katrol tetap tidak mengecilkan gaya yang diperlukan untuk mengangkat sebuah benda. Keuntungan dari katrol tetap adalah katrol tetap dapat mengubah arah gaya yang diperlukan untuk mengangkat beban. Contohnya saat mengangkat ember dalam sumur, kita menarik ember tersebut kebawah sehingga lebih mudah ditarik daripada kita tarik keatas.',
              ),
              const SizedBox(height: 16),
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/lesson/img_katrol.png',
                      width: 400,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: Listenable.merge(_animationControllers),
                        builder: (context, child) {
                          return CustomPaint(
                            painter: HorizontalLinePainter(
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
                        point.position.dx + point.lineLength,
                        point.position.dy,
                      );

                      return MapEntry(
                        index,
                        Positioned(
                          left: endPosition.dx,
                          top: endPosition.dy - 10,
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
              const SubtitleWithDescription(
                subtitle: 'Rumus-rumus Katrol Tetap',
                description:
                    'Untuk menghitung gaya kuasa, berat beban/benda, panjang lengan kuasa, panjang lengan beban, dan keuntungan mekanik pada katrol tetap, dapat digunakan rumus berikut:',
              ),
              const SizedBox(height: 16),
              const FormulaText(
                formula: "KM = W/F = 1",
                description:
                    "- KM = Keuntungan mekanik\n- W = Massa / Beban (N)\n- F = Gaya",
              ),
              const SizedBox(height: 16),
              const FormulaText(
                formula: 'KM = lk/lb = 1',
                description:
                    '- KM = Keuntungan mekanik\n- lk = lengan kuasa (m)\n- lb = lengan beban (N)',
              ),
              const SizedBox(height: 16),
              const QuestionButton(
                title: 'Contoh Soal Katrol Tetap',
                question:
                    'Sebuah benda dengan berat 70 N akan ditarik dengan katrol yang panjang lengan kuasanya sebesar 10 meter. Berapa gaya yang perlu dikeluarkan serta panjang lengan bebannya?',
                known: 'W = 70 N\nlk = 10 m',
                asked: 'F = ... ?\nlb = ... ?',
                answer:
                    'F = W x KM\nF = 70 x 1\nF = 70 N\nlb = lk x KM\nlb = 10 x 1\nlb = 10 m',
                conclusion:
                    'Sehingga gaya yang dibutuhkan untuk mengangkat beban adalah 70 N, sedangkan panjang lengan bebannya adalah 10 m.',
              )
            ],
          ),
        ),
      ),
    );
  }
}
