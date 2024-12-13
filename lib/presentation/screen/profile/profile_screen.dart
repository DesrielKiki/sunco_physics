import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunco_physics/presentation/screen/auth/login/login_screen.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _fullName;

  String? _email;
  String? _gender;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('user_data')
          .doc(user.uid)
          .get();

      setState(() {
        _fullName = userDoc['full_name'];

        _email = userDoc['user_email'];
        _gender = userDoc['user_gender'];
      });
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: ColorConfig.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(87),
                    bottomRight: Radius.circular(87),
                  ),
                ),
              ),
              Positioned(
                bottom: -50,
                child: Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        _gender == "male"
                            ? 'assets/ic_male.png'
                            : _gender == "female"
                                ? 'assets/ic_female.png'
                                : 'assets/ic_female.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Text(
            _fullName ?? "Loading...",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _email ?? "Email not available",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 32),
          Center(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorConfig.redWarning,
              ),
              child: TextButton(
                onPressed: _logout,
                child: const Text(
                  "Logout",
                  style: TextStyle(color: ColorConfig.onPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
