import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/component/auth_textfield.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _gender;
  bool _isLoading = true;

  Future<void> _saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('user_data')
            .doc(user.uid)
            .update({
          'full_name': _fullNameController.text,
          'username': _usernameController.text,
          'user_email': _emailController.text,
        });
        if (mounted) {
          Navigator.pop(context, true);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui profil: $e')),
        );
      }
    }
  }

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
        _fullNameController.text = userDoc['full_name'] ?? '';
        _usernameController.text = userDoc['username'] ?? '';
        _emailController.text = userDoc['user_email'] ?? '';
        _gender = userDoc['user_gender'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorConfig.onPrimaryColor,
        title: const Text('Edit Profile'),
        backgroundColor: ColorConfig.primaryColor,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                child: Column(
                  children: [
                    Container(
                      width: 128,
                      height: 128,
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
                    const SizedBox(
                      height: 64,
                    ),
                    AuthTextField(
                      label: "Nama",
                      hintText: "",
                      icon: Icons.person,
                      controller: _fullNameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthTextField(
                      label: "Username",
                      hintText: "",
                      icon: Icons.person,
                      controller: _usernameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthTextField(
                      label: "Email",
                      hintText: "user@example.com",
                      icon: Icons.email,
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthTextField(
                      label: "Masukkan Password",
                      hintText: "",
                      icon: Icons.person,
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          _saveChanges();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
