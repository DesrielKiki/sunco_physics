import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/screen/history/history_screen.dart';
import 'package:sunco_physics/presentation/screen/home/home_screen.dart';
import 'package:sunco_physics/presentation/screen/profile/profile_screen.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class HomeNavigationPage extends StatefulWidget {
  const HomeNavigationPage({super.key});

  @override
  State<HomeNavigationPage> createState() => _HomeNavigationPageState();
}

class _HomeNavigationPageState extends State<HomeNavigationPage> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _onTappedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Halaman utama
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages,
          ),
          // Bottom Navigation Bar dengan posisi custom
          Positioned(
            left: 0,
            right: 0,
            bottom: 30, // Atur jarak ke atas
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConfig.primaryColor,
                    border: Border.all(
                      color: ColorConfig.black, // Warna border
                      width: 1.5, // Ketebalan border
                    ),
                    borderRadius: BorderRadius.circular(20), // Sudut border
                  ),
                  child: BottomNavigationBar(
                    currentIndex: selectedIndex,
                    onTap: _onTappedItem,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          color: selectedIndex == 0
                              ? ColorConfig.onPrimaryColor
                              : ColorConfig.grey,
                        ),
                        label: selectedIndex == 0 ? 'Home' : '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.history,
                          color: selectedIndex == 1
                              ? ColorConfig.onPrimaryColor
                              : ColorConfig.grey,
                        ),
                        label: selectedIndex == 1 ? 'History' : '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                          color: selectedIndex == 2
                              ? ColorConfig.onPrimaryColor
                              : ColorConfig.grey,
                        ),
                        label: selectedIndex == 2 ? 'Profile' : '',
                      ),
                    ],
                    selectedItemColor: ColorConfig.onPrimaryColor,
                    unselectedItemColor: Colors.grey,
                    showSelectedLabels: true,
                    showUnselectedLabels: false,
                    elevation: 0, // Hilangkan shadow jika diperlukan
                    backgroundColor:
                        Colors.transparent, // Agar mengikuti container
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
