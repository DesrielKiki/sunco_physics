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

    // Validasi input
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog("Semua kolom harus diisi.");
      return;
    }

    if (newPassword != confirmPassword) {
      _showErrorDialog("Password baru dan konfirmasi password tidak cocok.");
      return;
    }

    if (newPassword.length < 6) {
      // Minimum 6 karakter untuk password baru
      _showErrorDialog("Password baru harus lebih dari 6 karakter.");
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      // Re-authenticate user dengan password lama
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Jika re-authenticate berhasil, update password
      await user.updatePassword(newPassword);

      setState(() {
        _isLoading = false;
      });

      _showSuccessDialog("Password berhasil diperbarui.");
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          _showErrorDialog("Password lama yang Anda masukkan salah.");
        } else {
          _showErrorDialog(
              "Terjadi kesalahan saat memperbarui password: ${e.message}");
        }
      } else {
        _showErrorDialog("Terjadi kesalahan yang tidak terduga.");
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true); // Kembali ke halaman sebelumnya
              },
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
                      height: 24,
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
