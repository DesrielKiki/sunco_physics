import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/component/subtitle_with_description.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class VectorLessonScreen extends StatelessWidget {
  const VectorLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConfig.primaryColor,
        foregroundColor: ColorConfig.onPrimaryColor,
        title: const Text(
          'Vektor',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SubtitleWithDescription(
                subtitle: 'Pengertian',
                description:
                    'Dalam ilmu fisika, vektor merupakan besaran yang memiliki nilai dan arah. Dalam konteks ini, vektor tidak hanya mencerminkan nilai besaran, tetapi juga mengindikasikan ke arah mana besaran tersebut bergerak. Contohnya adalah pada konsep gaya, di mana vektor gaya tidak sekadar mencerminkan besar gaya yang bekerja, melainkan juga menunjukkan arah gaya tersebut bekerja.',
              ),
              const SizedBox(height: 8.0),
              Image.asset('assets/lesson/img_vector1.png'),
              const SizedBox(height: 8.0),
              const SubtitleWithDescription(
                subtitle: 'Penulisan / Notasi Vektor',
                description:
                    'Penulisan/Notasi vektor dituliskan dengan simbol atau huruf tebal untuk resultan vektor.',
              ),
              const SizedBox(height: 8.0),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset('assets/lesson/img_vector_contoh.png')),
              const SizedBox(height: 8.0),
              const SubtitleWithDescription(
                subtitle: 'Mencari Besaran Vektor',
                description:
                    'Besaran vektor adalah besaran yang memiliki dua karakteristik utama, yaitu magnitude (nilai atau besarnya) dan arah. Beberapa contoh besaran vektor mencakup perpindahan, kecepatan, percepatan, momentum, dan gaya. Untuk menyatakan besaran vektor dengan jelas, perlu mencantumkan nilai besaran (dalam bentuk angka) sekaligus menentukan arah yang terkait.',
              ),
              const SizedBox(height: 8.0),
              const SubtitleWithDescription(
                subtitle: 'Contoh : ',
                description:
                    'Seorang wanita menarik koper dengan gaya 60N membentuk sudut 40°. Carilah gaya tarik horizonta dan verticalnya.\nDengan vektor kita bisa mencari kedua gaya yang ditaya tersebut. Pertama-tama kita bisa membuat visualisasinya dengan garis vektor',
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Image.asset('assets/lesson/img_vector2.png'),
                  Image.asset('assets/lesson/img_vector3.png'),
                ],
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Maka kita bisa menggunakan rumus',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/lesson/img_vector_rumus1.png'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/lesson/img_vector_rumus2.png'),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Dan akan menghasilkan jawaban : '),
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/lesson/img_vector_jwb1.png'),
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/lesson/img_vector_jwb2.png'),
              ),
              const SizedBox(height: 8.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dan untuk mencari resultan totalnya kita menggunakan rumus :',
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Image.asset('assets/lesson/img_vector_rumus3.png'),
                  const Text('Atau'),
                  Image.asset('assets/lesson/img_vector_rumus4.png'),
                ],
              ),
              const SubtitleWithDescription(
                subtitle: 'Mencari resultan vektor',
                description:
                    'Resultan vektor adalah vektor tunggal yang merupakan hasil dari penjumlahan atau penggabungan dari dua atau lebih vektor. Resultan ini mencerminkan total efek atau dampak dari vektor-vektor tersebut, baik dalam hal magnitude (besarnya) maupun arahnya.\n\nDalam konteks fisika, resultan vektor digunakan untuk menggambarkan hasil akhir dari berbagai gaya atau vektor yang bekerja pada suatu objek, membantu dalam menganalisis pergerakan atau keseimbangan benda dalam suatu sistem.',
              ),
              Image.asset('assets/lesson/img_vector4.png'),
              const Text(
                'Dari ilustrasi di atas kita bisa lihat banyak gaya yang terjadi dan memiliki sudut yang berbeda beda. Dan untuk mencari semua total gayanya kita bisa menggunakan resultan vektor. Pertama kita cari besaran vektor dari tiap tiap gaya baik secara vertikal ataupun horizontal Nb. Untuk arah gaya ke arah kiri atau -x atau ke bawah atau -y akan bernilai negatif',
              ),
              const SizedBox(height: 8.0),
              Image.asset('assets/lesson/img_vektor_jwb3.png'),
              const SizedBox(height: 8.0),
              const Text(
                'Lalu kita gabungkan semua hasil yang sudah kita temukan menjadi fx dan fy untuk mempermudah mencari resultan vektornya : ',
              ),
              const SizedBox(height: 8.0),
              Image.asset('assets/lesson/img_vector5.png'),
              const SizedBox(height: 8.0),
              const Text(
                'Dan langkah terakhir kita bisa mencari resultannya : ',
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/lesson/img_vector_rumus5.png'),
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/lesson/img_vector_rumus6.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
