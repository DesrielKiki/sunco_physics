import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/interactive_point.dart';
import 'package:sunco_physics/presentation/component/formula_text.dart';
import 'package:sunco_physics/presentation/component/lesson_dialog.dart';
import 'package:sunco_physics/presentation/component/question_button.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/component/vertical_line_painter.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class PotentialEnergyLessonScreen extends StatefulWidget {
  const PotentialEnergyLessonScreen({super.key});

  @override
  State<PotentialEnergyLessonScreen> createState() =>
      _PotentialEnergyLessonScreenState();
}

class _PotentialEnergyLessonScreenState
    extends State<PotentialEnergyLessonScreen> with TickerProviderStateMixin {
  final List<InteractivePoint> points = [
    InteractivePoint(
      position: const Offset(96, 105),
      lineLength: 200,
      title: "Massa",
      description:
          'Massa adalah gaya yang ditimbulkan oleh gravitasi pada sebuah benda. Massa menunjukkan seberapa kuat gravitasi menarik benda tersebut ke bawah. Berat berbeda dari massa, karena berat tidak tergantung pada gravitasi, sedangkan massa iya. Misalnya: Di Bumi, kamu merasa lebih "berat" karena gravitasi Bumi lebih besar. Di Bulan, kamu akan merasa lebih "ringan" karena gravitasi Bulan lebih kecil. Massa biasanya diukur dalam satuan Newton (N), sedangkan berat diukur dalam kilogram (kg)',
    ),
    InteractivePoint(
      position: const Offset(134.5, 105),
      lineLength: 140,
      title: "Percepatan Gravitasi",
      description:
          'Percepatan gravitasi adalah percepatan yang dialami oleh benda saat jatuh bebas akibat tarikan gravitasi suatu planet atau benda langit. Di Bumi, percepatan gravitasi rata-rata bernilai 9,8 m/s². Artinya, setiap detik benda yang jatuh akan bertambah kecepatannya sebesar 9,8 meter per detik, jika tidak ada hambatan seperti udara. Sebagai contoh, jika sebuah apel jatuh dari pohon, percepatan gravitasi ini yang membuatnya semakin cepat saat mendekati tanah.',
    ),
    InteractivePoint(
      position: const Offset(176, 270),
      lineLength: 50,
      title: "Tinggi",
      description:
          'Tinggi adalah jarak vertikal dari suatu benda, titik, atau objek diukur dari permukaan tertentu, biasanya permukaan tanah atau dasar lainnya. Tinggi menunjukkan seberapa jauh sesuatu berada di atas atau di bawah titik acuan tersebut.',
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
        title: const Text("Energi Potensial"),
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SubtitleWithDescription(
                subtitle: "Apa itu energi?",
                description:
                    "Energi adalah sesuatu yang sangat melekat dalam setiap aktivitas kehidupan. Secara sederhana, energi dapat diartikan sebagai kemampuan suau benda untuk melakukan suatu usaha. Suatu benda dikatakan memiliki energi ketika benda tersebut mampu menghasilkan gaya yang dapat melakukan kerja. Ada tiga jenis energi, yaitu energi potensial, energi mekanik, dan energi kinetik",
              ),
              const SizedBox(height: 16),
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/lesson/img_potential_energy.png',
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
              const SubtitleWithDescription(
                subtitle: "Energi Potensial Gravitasi",
                description:
                    "Energi potensial gravitasi adalah energi potensial yang disebabkan oleh gaya gravitasi bumi. Jika sebuah batu jatuh dari ketinggian tertentu tanpa kecepatan awal, maka benda akan jatuh dan membentur tanah atau lantai. Benda itu sudah melakukan usaha terhadap tanah atau lantai.",
              ),
              const SizedBox(height: 16),
              const Text(
                "Untuk menghitung usaha, dapat digunakan rumus berikut:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const FormulaText(
                  formula: "Ep = m x g x h",
                  description:
                      "- Ep = Energi potensial (Joule)\n- m = Massa benda (kg)\n- g = Percepatan gravitasi (10 m/s²)\n- h = Ketinggian benda (m)"),
              const SizedBox(height: 16),
              const QuestionButton(
                title: "Soal 1",
                question:
                    "Diketahui sebuah lemari bermassa 10 kg dinaikkan ke lantai 8 sebuah gedung apartemen dengan energi potensial sebesar 2000 Joule. Berapa tinggi lantai ke-8 apartemen tersebut? (g = 10 m/s²)",
                known: "m = 10 kg\nEp = 2000 joule\ng = 10 m/s²",
                asked: "H = ... ? ",
                answer:
                    "Ep = m x g x h\nh = Ep / m x g\nh = 2000 / 10 x 10 = 20 meter\nh = 20 meter",
                conclusion:
                    "Sehingga tinggi lantai ke-8 apartemen tersebut adalah 20 meter.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
