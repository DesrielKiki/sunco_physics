import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/component/formula_text.dart';
import 'package:sunco_physics/presentation/component/question_button.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class KineticEnergyLessonScreen extends StatelessWidget {
  const KineticEnergyLessonScreen({super.key});

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
              Image.asset(
                'assets/lesson/img_energi_kinetik.png',
                width: 400,
                height: 300,
                fit: BoxFit.contain,
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
