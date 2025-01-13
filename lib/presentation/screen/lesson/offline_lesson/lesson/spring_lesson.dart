import 'package:flutter/material.dart';
import 'package:sunco_physics/data/model/interactive_point.dart';
import 'package:sunco_physics/presentation/component/bullet_point_list.dart';
import 'package:sunco_physics/presentation/component/formula_text.dart';
import 'package:sunco_physics/presentation/component/lesson_dialog.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/component/vertical_line_painter.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class SpringLessonScreen extends StatefulWidget {
  const SpringLessonScreen({super.key});

  @override
  State<SpringLessonScreen> createState() => _SpringLessonScreenState();
}

class _SpringLessonScreenState extends State<SpringLessonScreen>
    with TickerProviderStateMixin {
  final List<InteractivePoint> points = [
    InteractivePoint(
      position: const Offset(150, 195),
      lineLength: 65,
      title: "Massa",
      description:
          'Massa adalah gaya yang ditimbulkan oleh gravitasi pada sebuah benda. Massa menunjukkan seberapa kuat gravitasi menarik benda tersebut ke bawah. Berat berbeda dari massa, karena berat tidak tergantung pada gravitasi, sedangkan massa iya. Misalnya: Di Bumi, kamu merasa lebih "berat" karena gravitasi Bumi lebih besar. Di Bulan, kamu akan merasa lebih "ringan" karena gravitasi Bulan lebih kecil. Massa biasanya diukur dalam satuan Newton (N), sedangkan berat diukur dalam kilogram (kg)',
    ),
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
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Gaya Pegas',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SubtitleWithDescription(
                subtitle: 'Apa itu gaya pegas?',
                description:
                    'Gaya pegas sering disebut dengan gaya elastis atau karet karena gaya pegas memiliki bentuk yang dapat berubah menjadi lebih panjang dari bentuk semula. Padahal kenyataanya, pegas dihasilkan dari benda dengan bahan logam dan tidak memiliki kelenturan. Hanya saja karena adanya gaya yang dihasilkan itulah, benda berbahan logam menjadi bersifat elastis.',
              ),
              const SizedBox(height: 16),
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/lesson/img_spring.png',
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
              const SubtitleWithDescription(
                subtitle: 'Hukum Hooke',
                description:
                    'Dalam ilmu fisika, gaya pegas disebut dengan istilah Hukum Hooke.\n\nHukum Hooke merupakan sebuah ilmu yang mengkaji jumlah gaya maksimum yang diberikan pada sebuah benda yang bersifat elastis (sifat elastis sering dimiliki oleg pegas) agar tidak dapat melewati batas elasitas yang dapat menyebabkan benda tersebut kehilangan sifat elasisnya.',
              ),
              const SizedBox(height: 16),
              const SubtitleWithDescription(
                subtitle: 'Bunyi Hukum Hooke',
                description:
                    '“Jika gaya tarik yang diberikan pada sebuah benda pegas tidak melebihi batas elastisnya, maka pertambahan panjang benda yang terjadi menjadi sebanding dengan gaya tarik yang diberikan”',
              ),
              const SizedBox(height: 16),
              const Text(
                'beberapa contoh benda yang memiliki gaya pegas dan digunakan dalam kebutuhan sehari-hari, antara   lain:',
              ),
              const SizedBox(height: 16),
              const BulletPointList(
                items: [
                  'Jam kasa memiliki nilai gaya pegas yang berfungsi untuk memberikan informasi lokasi kapal pada saat berada di tengah laut',
                  'Sambungan komponen persneling pada kendaraan memanfaatkan gaya pegas untuk dapat bekerja dengan baik.',
                  'Teleskop memiliki sistem kerja yang dapat digunakan untuk melihat benda luar angkasa agar terlihat lebih dekat.',
                  'Mikroskop berfungsi untuk melihat benda atau komponen kecil yang tak tampak kasat mata.',
                  'Ayunan juga menerapkan sistem gaya pegas.',
                  'Alat ukur gravitasi bumi juga menggunakan pegas.',
                ],
              ),
              const SizedBox(height: 16),
              const SubtitleWithDescription(
                subtitle: 'Rumus Gaya Pegas',
                description:
                    'Gaya pegas didefinisikan dalam hukum hooke. Hukum hooke juga dihitung dan mendapat angka untuk mendefinisikan gaya tersebut. Berikut ini penulisan sistematis rumus gaya pegas:',
              ),
              const SizedBox(height: 16),
              const Image(
                image: AssetImage(
                  'assets/lesson/img_spring_2.png',
                ),
              ),
              const SizedBox(height: 16),
              const FormulaText(
                formula: 'F = k * x',
                description:
                    'F = gaya yang diberikan pada suatu pegas (N)\nk = konstanta yang dimiliki pegas (N/m)\nx = pertambahan panjang pegas akibat dari gaya (m)',
              ),
              const SizedBox(height: 16),
              const Text(
                'Secara matematis, hukum Hooke ini dinyatakan sebagai berikut :',
              ),
              const FormulaText(
                formula: 'F = k * Δx',
                description:
                    "F : Gaya Berat atau Gaya Pegas atau Gaya yg Bekerja pada Pegas\nk : Konstanta Pegas\nΔx: Pertambahan Panjang",
              ),
              const SizedBox(height: 16),
              const SubtitleWithDescription(
                subtitle: "Energi Potensial Pegas",
                description:
                    "Pegas yang diberi gaya tarik atau gaya tekan akan memiliki energi potensial. Sifat elastis pada pegas membuat energi potensial bergantung pada besar gaya yang diberikan untuk meregangkan sebuah benda.\nPerhatikan pada gambar dibawah ini. Usaha yang dilakukan pada Gaya F untuk menarik sebuah pegas sehingga bertambah panjang sebesar X besarnya sama dengan perubahan energi potensial dari pegas.",
              ),
              const SizedBox(height: 16),
              const Image(
                image: AssetImage('assets/lesson/img_spring_3.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Bagian gambar yang terarsir merupakan usaha sama dengan perubahan energi potensial. Maka rumus yang digunakan untuk menghitung energi potensial adalah sebagai berikut:',
              ),
              const SizedBox(height: 16),
              const FormulaText(
                formula: 'Ep = ½ k Δx2',
                description:
                    'K = konstanta pegas (N/m)\nEp = energi potensial pegas (J)\nΔx = pertambahan panjang pegas (m)',
              ),
              const SizedBox(height: 16),
              // QuestionButton(
              //     title: title,
              //     question: question,
              //     known: known,
              //     asked: asked,
              //     answer: answer,
              //     conclusion: conclusion)
            ],
          ),
        ),
      ),
    );
  }
}
