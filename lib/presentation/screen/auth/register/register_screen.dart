import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunco_physics/data/helper/firebase_helper.dart';
import 'package:sunco_physics/data/helper/validation_helper.dart';
import 'package:sunco_physics/presentation/component/auth_button.dart';
import 'package:sunco_physics/presentation/component/auth_support_text.dart';
import 'package:sunco_physics/presentation/component/auth_textfield.dart';
import 'package:sunco_physics/presentation/navigation/home_navigation.dart';
import 'package:sunco_physics/presentation/screen/auth/login/login_screen.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  final FirebaseHelper _firebaseHelper = FirebaseHelper();

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    // Validasi Input
    List<String> errors = [];
    String? emailError = ValidationHelper.validateEmail(_emailController.text);
    String? passwordError =
        ValidationHelper.validatePassword(_passwordController.text);
    String? fullNameError = ValidationHelper.validateField(
        _fullNameController.text, "Nama Lengkap");
    String? usernameError =
        ValidationHelper.validateField(_usernameController.text, "Username");

    if (emailError != null) errors.add(emailError);
    if (passwordError != null) errors.add(passwordError);
    if (fullNameError != null) errors.add(fullNameError);
    if (usernameError != null) errors.add(usernameError);

    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errors.join('\n'))),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Registrasi Firebase
      UserCredential? userCredential = await _firebaseHelper.registerUser(
        _emailController.text,
        _passwordController.text,
      );

      if (userCredential != null) {
        // Simpan Data Pengguna
        await _firebaseHelper.saveUserData(
          userCredential.user!.uid,
          _emailController.text,
          _fullNameController.text,
          _usernameController.text,
        );

        // Menyimpan Status Login
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeNavigationPage()),
            (route) => false,
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi gagal. Silakan coba lagi.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registrasi gagal')),
      );
    } catch (e) {
      debugPrint('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan. Silakan coba lagi.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: ColorConfig.gradientBrand),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: ColorConfig.onPrimaryColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Welcome. Enter your email and Password to sign up",
                    style: TextStyle(
                        color: ColorConfig.onPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  AuthTextField(
                    controller: _fullNameController,
                    label: "Full Name",
                    hintText: "Your Full Name",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _usernameController,
                    label: "Username",
                    hintText: "Your username",
                    icon: Icons.person_2_outlined,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _emailController,
                    label: "Email",
                    hintText: "user@example.com",
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _passwordController,
                    label: "Password",
                    hintText: "Your Password",
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),
                  AuthButton(
                    buttonText: _isLoading ? "Loading..." : "Sign Up",
                    onPressed: _isLoading ? null : _register,
                  ),
                  const SizedBox(height: 16),
                  SupportText(
                    firstText: "Already have an account? ",
                    secondText: "Sign in",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
