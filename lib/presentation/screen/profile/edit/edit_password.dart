import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/component/auth_textfield.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _fullName;
  String? _email;
  String? _gender;
  String? _errorMessage;

  bool _isLoading = false;

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

  Future<void> _updatePassword() async {
    final user = FirebaseAuth.instance.currentUser;

    String oldPassword = _oldPasswordController.text.trim();
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _errorMessage = null; // Reset error message
    });

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = "Semua kolom harus diisi.";
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        _errorMessage = "Password baru dan konfirmasi password tidak cocok.";
      });
      return;
    }

    if (newPassword.length < 6) {
      setState(() {
        _errorMessage = "Password baru harus lebih dari 6 karakter.";
      });
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      setState(() {
        _isLoading = false;
        _errorMessage = null; // Clear error message on success
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password berhasil diperbarui.")),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          setState(() {
            _errorMessage = "Password lama yang Anda masukkan salah.";
          });
        } else {
          setState(() {
            _errorMessage = "Password lama yang Anda masukkan salah.";
          });
        }
      } else {
        setState(() {
          _errorMessage = "Terjadi kesalahan yang tidak terduga.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorConfig.onPrimaryColor,
        title: const Text('Edit Password'),
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
                      height: 12,
                    ),
                    Text(
                      _fullName ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _email ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    AuthTextField(
                      label: "Your Old Password",
                      hintText: "",
                      icon: Icons.lock,
                      obscureText: true,
                      controller: _oldPasswordController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthTextField(
                      label: "Your New Password",
                      hintText: "",
                      icon: Icons.lock,
                      obscureText: true,
                      controller: _newPasswordController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AuthTextField(
                      label: "Confirm New Password",
                      hintText: "",
                      icon: Icons.lock,
                      obscureText: true,
                      controller: _confirmPasswordController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (_errorMessage != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16, left: 8),  
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _updatePassword,
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
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                            : const Text(
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
