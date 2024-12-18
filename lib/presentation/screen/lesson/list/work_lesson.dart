import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/interactive_point.dart';
import 'package:sunco_physics/presentation/component/vertical_line_painter.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';
import 'package:sunco_physics/presentation/component/lesson_dialog.dart';

class WorkLessonScreen extends StatefulWidget {
  const WorkLessonScreen({super.key});

  @override
  State<WorkLessonScreen> createState() => _WorkLessonScreenState();
}

class _WorkLessonScreenState extends State<WorkLessonScreen> with TickerProviderStateMixin {
  final List<InteractivePoint> points = [
    InteractivePoint(
      position: const Offset(45, 210),
      lineLength: 60,
      description:
          "Kotak A: Benda ini awalnya dalam posisi diam sebelum gaya diberikan.",
    ),
    InteractivePoint(
      position: const Offset(190, 135),
      lineLength: 135,
      description: "Gaya: Ini adalah arah gaya yang bekerja pada benda.",
    ),
    InteractivePoint(
      position: const Offset(75, 237),
      lineLength: 33,
      description: "Kotak B: Posisi akhir benda setelah mengalami usaha.",
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
    opacityValues =
        List.generate(points.length, (_) => 1.0); // Mulai dengan opacity penuh

    // Inisialisasi AnimationController untuk setiap titik
    _animationControllers = List.generate(
      points.length,
      (_) => AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      )..repeat(reverse: true), // Ulangi animasi dengan efek reverse
    );

    // Membuat animasi kedip (opacity)
    _opacityAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(begin: 1.0, end: 0.5).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          ),
        )
        .toList();

    // Debugging: Menampilkan status awal
    debugPrint('Initial opacityValues: $opacityValues');
  }

  @override
  void dispose() {
    // Menyelesaikan controller animasi ketika tidak digunakan lagi
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Fungsi untuk menampilkan deskripsi titik
  void _showDescription(String description) {
    debugPrint("Menampilkan deskripsi: $description");
    showDialog(
      context: context,
      builder: (context) => LessonDialog(description: description),
    );
  }

  // Fungsi untuk menangani klik pada titik
  void _onPointClicked(int index) {
    if (!clickedPoints[index]) {
      debugPrint('Titik $index diklik');
      // Mengatur opacity ke 1.0 terlebih dahulu sebelum menghentikan animasi
      setState(() {
        opacityValues[index] = 1.0; // Mengembalikan opacity ke 1
        clickedPoints[index] = true; // Menandai bahwa titik sudah diklik
      });

      // Debugging: Status setelah opacity diatur
      debugPrint('Opacity setelah diklik untuk titik $index: ${opacityValues[index]}');

      // Memberikan sedikit delay sebelum animasi dihentikan dan deskripsi ditampilkan
      Future.delayed(const Duration(milliseconds: 300), () {
        // Hentikan animasi pada titik yang diklik
        _animationControllers[index].stop();

        // Debugging: Menampilkan status setelah animasi dihentikan
        debugPrint('Animasi dihentikan untuk titik $index');
        
        // Menampilkan deskripsi titik setelah animasi dihentikan
        _showDescription(points[index].description);
      });
    } else {
      debugPrint('Titik $index sudah diklik sebelumnya');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Materi Usaha"),
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Apa Itu Usaha?\n\nUsaha (W) adalah energi yang disalurkan gaya ke suatu benda sehingga benda tersebut bergerak.\n\nRumus usaha dapat dituliskan sebagai berikut:",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            const Center(
              child: Text(
                "W = F x s x cos(θ)",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/lesson/work/usaha_1.png',
                    width: 400,
                    height: 300,
                    fit: BoxFit.contain,
                  ),

                  // Menggambar garis dengan animasi kedip
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

                  // Menambahkan titik interaktif dengan animasi kedip
                  ...points
                      .asMap()
                      .map((index, point) {
                        final Offset endPosition = Offset(
                          point.position.dx,
                          point.position.dy + point.lineLength,
                        );

                        return MapEntry(
                          index,
                          Positioned(
                            left: endPosition.dx - 8,
                            top: endPosition.dy - 8,
                            child: FadeTransition(
                              opacity: _opacityAnimations[index],
                              child: GestureDetector(
                                onTap: () {
                                  _onPointClicked(index); // Fungsi untuk menangani klik
                                },
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      .values
                      .toList(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Contoh Soal Usaha:\n\n1. Sebuah benda didorong sejauh 5 meter dengan gaya sebesar 10 N. Berapa usaha yang dilakukan jika arah gaya sejajar dengan perpindahan?",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

