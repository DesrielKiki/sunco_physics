import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn = false;

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Access Denied"),
          content: const Text("Please log in to access the calculator."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 192.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 64.0, vertical: 52.0),
            decoration: const BoxDecoration(
              color: ColorConfig.darkBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(87),
                bottomRight: Radius.circular(87),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15.0,
                  offset: Offset(0, 6),
                  spreadRadius: 4.0,
                ),
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Anda Bisa Belajar dan Menghitung Disini',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(height: 52),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.0),
            child: Text(
              'Choose menu',
              style: TextStyle(
                fontSize: 28,
                color: ColorConfig.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: isLoggedIn
                ? () {
                    Navigator.pushNamed(context, '/calculatorList');
                  }
                : _showAlertDialog,
            child: Container(
              width: double.infinity,
              height: 188,
              margin: const EdgeInsets.symmetric(horizontal: 32.0),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                color: isLoggedIn ? ColorConfig.darkBlue : ColorConfig.grey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12.0,
                    offset: Offset(0, 4),
                    spreadRadius: 3.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'Kalkulator',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Image.asset(
                    'assets/ic_kalkulator.png',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/lessonList');
            },
            child: Container(
              width: double.infinity,
              height: 188,
              margin: const EdgeInsets.symmetric(horizontal: 32.0),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: const BoxDecoration(
                color: ColorConfig.darkBlue,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12.0,
                    offset: Offset(0, 4),
                    spreadRadius: 3.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/ic_book.png',
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Text(
                        'Materi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
