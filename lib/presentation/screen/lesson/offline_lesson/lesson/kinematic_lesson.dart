import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/component/question_button.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class KinematicLessonScreen extends StatelessWidget {
  const KinematicLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kinematik'),
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SubtitleWithDescription(
                subtitle: 'Apa itu kinematika',
                description:
                    'Kinematika adalah cabang ilmu fisika dalam mekanika klasik yang mempelajari gerak suatu benda tanpa meninjau penyebab benda tersebut bergerak. Kinematika mempelajari gerak sebagai fungsi waktu. salah satu materi yang termasuk kedalam kinematika adalah GLB(Gerak Lurus Beraturan), GLBB(Gerak Lurus Berubah Beraturan) dan gerak melingkar beraturan.',
              ),
              const SizedBox(height: 16.0),
              Image.asset('assets/lesson/img_kinematic1.png'),
              const SizedBox(height: 16.0),
              const Text(
                'Gerak adalah sebuah perpindahan benda dari satu titik ke titik lainnya. Sementara Gerak lurus beraturan atau GLB adalah perpindahan benda dengan kecepatan yang konstan atau tidak berubah secara lurus pada selang waktu tertentu. Contoh GLB adalah sebuah mobil yang bergerak pada jalan yang lurus dengan kecepatan 60 km/jam selama 5 jam (kecepatan tidak berubah sama sekali).',
              ),
              const SizedBox(height: 16.0),
              const SubtitleWithDescription(
                subtitle: 'Rumus-rumus Gerak Lurus Beraturan (GLB)',
                description:
                    'Untuk menghitung kecepatan, jarak, waktu, dan kedudukan setelah t detik pada GLB, dapat digunakan rumus-rumus berikut:',
              ),
              const SizedBox(height: 16.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kecepatan (v)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('v = s / t'),
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Jarak (s)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('s = v × t'),
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Waktu (t)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('t = s / v'),
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kedudukan setelah t detik (st)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('st = s0 + (v × t)'),
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Keterangan : ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '- v = kecepatan (m/detik)\n- t = waktu (detik)\n- s = jarak / kedudukan (m)\n- s0 = kedudukan awal (m)\n- st = kedudukan setelah t detik (m)'),
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contoh soal gerak Lurus Berubah Beraturan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 8.0),
              const QuestionButton(
                title: 'Soal GLBB',
                question:
                    'Jika sebuah benda bergerak dengan percepatan 10 m/detik, hitunglah kecepatan benda tersebut setelah 5 detik! Lalu hitung kedudukan benda tersebut setelah 15 detik!',
                known: '- a = 10 m/detik\n- v0 = 0 (diam)\n- t = 5 detik',
                asked:
                    '1. Kecepatan benda (v) = . . . ?\n2. Kedudukan benda setelah 15 detik = . . . ?',
                answer:
                    '1. vt = v0 + a × t\nvt = 0 + 10 × 5\nvt = 50 m/detik\n\n2. \ts = v0 × t + 1/2 × a × t2\ns = 0 × 15 + 1/2 × 10 × 152\ns = 1125 m ',
                conclusion:
                    'Sehingga kecepatan benda tersebut adalah 50 m/detik dan kedudukan benda setelah 15 detik adalah 1125 m',
              ),
              const SizedBox(height: 16.0),
              const SubtitleWithDescription(
                subtitle: 'apa perbedaan glb dan glbb?',
                description:
                    'Perbedaan dari GLB dan GLBB adalah untuk GLB perpindahan terjadi dengan kecepatan yang konstan, sementara untuk GLBB, perpindahan terjadi dengan kecepatan yang terus berubah. Oleh karena itu pada dunia nyata, GLBB lebih sering terjadi daripada GLB karena perpindahan yang kecepatannya tidak berubah sangat jarang terjadi.',
              ),
              const SizedBox(height: 16.0),
              const SubtitleWithDescription(
                subtitle: 'apa itu gerak melingkar beraturan?',
                description:
                    'Gerak melingkar adalah gerak yang lintasannya berbentuk lingkaran dan memiliki satu titik pusat. Gerak melingkar beraturan sebenarnya mirip dengan Gerak lurus beraturan, yaitu gerak yang kecepatannya konstan atau tidak berubah, hanya saja lintasannya merupakan lingkaran. Contoh dari gerak melingkar beraturan adalah geraknya jarum jam dan komedi putar.',
              ),
              const SizedBox(height: 16.0),
              Image.asset('assets/lesson/img_kinematic2.png'),
              const SizedBox(height: 16.0),
              const Text(
                'Rumus untuk menghitung kecepatan sudut, kecepatan linear, periode, dan sudut dalam gerak melingkar beraturan adalah sebagai berikut :',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kecepatan sudut (ω)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('ω = θ / t\nω = 2π / T\nω = 2πfω = v / r'),
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kecepatan linear(v)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('v = w / r'),
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Periode (T)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('T = 1 / f\nT = 2π / w'),
              ),
              const SizedBox(height: 16.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Contoh Soal Gerak Melingkar Beraturan',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
              ),
              const SizedBox(height: 8.0),
              const QuestionButton(
                  title: 'Soal Gerak Melingkar Beraturan',
                  question:
                      'Suatu roda berputar dengan kecepatan sudut tetap 120 rpm. Jari-jari roda adalah 50 cm. Hitung kecepatan linear benda yang berada di tepi roda!',
                  known: '- ω = 120 rpm\n- r = 50 cm = 0.5 m',
                  asked: 'v = . . . ?',
                  answer:
                      'ω = 120 rpm = 120 x 2π / 60 = 4π rad/s\nv = ω x r = 4π x 0.5 = 2π m/s',
                  conclusion: 'Sehingga kecepatan linear benda adalah 2π')
            ],
          ),
        ),
      ),
    );
  }
}
