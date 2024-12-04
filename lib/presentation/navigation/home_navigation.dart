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

  // List of pages to navigate
  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  // Handle navigation bar item taps
  void _onTappedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex], // Render the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onTappedItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color:
                  selectedIndex == 0 ? ColorConfig.primaryColor : Colors.grey,
            ),
            label: selectedIndex == 0 ? 'Home' : '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color:
                  selectedIndex == 1 ? ColorConfig.primaryColor : Colors.grey,
            ),
            label: selectedIndex == 1 ? 'History' : '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color:
                  selectedIndex == 2 ? ColorConfig.primaryColor : Colors.grey,
            ),
            label: selectedIndex == 2 ? 'Profile' : '',
          ),
        ],
        selectedItemColor: ColorConfig.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        elevation: 10,
        backgroundColor: Colors.white,
      ),
    );
  }
}
