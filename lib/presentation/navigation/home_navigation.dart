import 'package:flutter/material.dart';

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
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConfig.primaryColor,
                    border: Border.all(
                      color: ColorConfig.black,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
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
                          Icons.person,
                          color: selectedIndex == 1
                              ? ColorConfig.onPrimaryColor
                              : ColorConfig.grey,
                        ),
                        label: selectedIndex == 1 ? 'Profile' : '',
                      ),
                    ],
                    selectedItemColor: ColorConfig.onPrimaryColor,
                    unselectedItemColor: Colors.grey,
                    showSelectedLabels: true,
                    showUnselectedLabels: false,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
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
