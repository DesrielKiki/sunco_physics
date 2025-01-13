import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/component/formula_text.dart';
import 'package:sunco_physics/presentation/component/question_button.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class MechanicalEnergyLesson extends StatelessWidget {
  const MechanicalEnergyLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Energi Mekanik'),
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SubtitleWithDescription(
                subtitle: 'Energi Mekanik',
                description:
                    'Energi Mekanik adalah total dari energi potensial dan energi kinetik. Contoh energi mekanik sederhana adalah ketika melakukan service pada permainan badminton. Ketika bola dipukul oleh pemain badminton, pemain badminton tersebut mengeluarkan energi kinetik, dan bola yang terbang memiliki energi potensial, kemudian jatuh ke lapangan lawan. Rangkaian aktivitas pada permainan badminton adalah contoh penggunaan energi mekanik dalam kehidupan sehari-hari.',
              ),
              const SizedBox(height: 16.0),
              Image.asset('assets/lesson/img_mechanical_energy.png'),
              const SizedBox(height: 16.0),
              const Text(
                'Rumus untuk menghitung energi mekanik adalah sebagai berikut:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Rumus Energi Mekanik'),
              ),
              const SizedBox(height: 16.0),
              const FormulaText(
                  formula: 'Em = Ep + Ek',
                  description:
                      '- Em = Energi Mekanik\n- Ep = Energi Potensial\n- Ek = Energi Kinetik'),
              const SizedBox(height: 32.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Rumus Hukum Kekekalan Energi Mekanik'),
              ),
              const SizedBox(height: 16.0),
              const FormulaText(
                formula: 'Em1 = Em2 atau Ep1 + Ek1 = Ep2 ',
                description:
                    '- Em = Energi Mekanik\n- Ep = Energi Potensial\n- Ek = Energi Kinetik',
              ),
              const SizedBox(height: 16.0),
              const QuestionButton(
                  title: 'Soal',
                  question:
                      'Sebuah apel memiliki massa 300 gram (0.3 kg) jatuh dari pohonnya pada ketinggian 10 meter. Jika g =10 m/detik2, berapakah energi mekanik pada apel?',
                  known:
                      '- m = 300 gram = 0,3 kg\n- h = 10 meter\n- g = 10m/s^2',
                  asked: 'Em = . . . ?',
                  answer:
                      'Em = Ep + Ek\nEm = (m × g × h) + (1/2 × m × v2)\nEm = (0.3 × 10 × 10) + (1/2 × 0.3 × 02)\nEm = (30) + (0)\nEm = 30 Joule',
                  conclusion:
                      'Sehingga Energi mekanik apel tersebut adalah 30 Joule')
            ],
          ),
        ),
      ),
    );
  }
}
