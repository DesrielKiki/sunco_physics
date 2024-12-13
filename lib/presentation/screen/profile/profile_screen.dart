import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunco_physics/presentation/component/edit_profile_button.dart';
import 'package:sunco_physics/presentation/screen/auth/login/login_screen.dart';
import 'package:sunco_physics/presentation/screen/profile/edit/edit_profile.dart';
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

      if (mounted) {
        setState(() {
          _fullName = userDoc['full_name'];
          _email = userDoc['user_email'];
          _gender = userDoc['user_gender'];
        });
      }
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
      body: SingleChildScrollView(
        child: Column(
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
                                  : 'assets/ic_gender_default.png',
                        ),
                        fit: BoxFit.cover,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Column(
                children: [
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
                  EditProfileButton(
                      buttonText: "Edit Profil",
                      buttonIcon: Icons.edit,
                      onPressed: () async {
                        bool? isUpdated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()),
                        );
                        if (isUpdated != null && isUpdated) {
                          _loadUserData();
                        }
                      }),
                  const SizedBox(height: 12),
                  EditProfileButton(
                    buttonText: "Edit Password",
                    buttonIcon: Icons.edit,
                    onPressed: () {
                      Navigator.pushNamed(context, "/edit_password");
                    },
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 50,
                    ),
                    child: EditProfileButton(
                      buttonText: "Logout",
                      buttonIcon: Icons.logout,
                      onPressed: _logout,
                      buttonColor: ColorConfig.redWarning,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
