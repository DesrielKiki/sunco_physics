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
  final PageController _pagecontroller = PageController();

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
    _pagecontroller.animateToPage(
      index,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pagecontroller,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 52),
        child: ClipRRect( 
          borderRadius: BorderRadius.circular(20),
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
            elevation: 10,
            backgroundColor: ColorConfig.primaryColor,
          ),
        ),
      ),
    );
  }
}
