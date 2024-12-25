import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/component/formula_text.dart';
import 'package:sunco_physics/presentation/component/question_button.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class PotentialEnergyLessonScreen extends StatelessWidget {
  const PotentialEnergyLessonScreen({super.key});

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
              Image.asset(
                'assets/lesson/img_potential_energy.png',
                width: 400,
                height: 300,
                fit: BoxFit.contain,
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
