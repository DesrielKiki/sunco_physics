import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunco_physics/data/helper/firebase_helper.dart';
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
  final FirebaseHelper _firebaseHelper = FirebaseHelper();

  String? _gender;
  bool _isLoading = true;
  String? _errorMessage;

  Future<void> _loadUserData() async {
    try {
      final user = await _firebaseHelper.getCurrentUser();
      if (user != null) {
        final userDoc = await _firebaseHelper.getUserData(user.uid);
        setState(() {
          _fullNameController.text = userDoc['full_name'] ?? '';
          _usernameController.text = userDoc['username'] ?? '';
          _emailController.text = userDoc['user_email'] ?? '';
          _isLoading = false;
        });
      }
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  Future<bool> _verifyPassword(String password) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) return false;

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _saveChanges() async {
    final user = await _firebaseHelper.getCurrentUser();
    if (user == null) return;

    if (_passwordController.text.isEmpty) {
      setState(() => _errorMessage = "Password harus diisi.");
      return;
    }

    final isPasswordValid = await _firebaseHelper.verifyPassword(
      user.email!,
      _passwordController.text,
    );

    if (!isPasswordValid) {
      setState(() => _errorMessage =
          "Password salah. Harap masukkan password yang benar.");
      return;
    }

    try {
      await _firebaseHelper.updateUserData(user.uid, {
        'full_name': _fullNameController.text,
        'username': _usernameController.text,
        'user_email': _emailController.text,
      });
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
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
                      icon: Icons.lock,
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    if (_errorMessage != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _saveChanges,
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
