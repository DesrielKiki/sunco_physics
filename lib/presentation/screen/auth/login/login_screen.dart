import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunco_physics/data/helper/validation_helper.dart';
import 'package:sunco_physics/presentation/component/auth_button.dart';
import 'package:sunco_physics/presentation/component/auth_support_text.dart';
import 'package:sunco_physics/presentation/component/auth_textfield.dart';
import 'package:sunco_physics/presentation/navigation/home_navigation.dart';
import 'package:sunco_physics/presentation/screen/auth/register/register_screen.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String? emailError = ValidationHelper.validateEmail(_emailController.text);
    String? passwordError =
        ValidationHelper.validatePassword(_passwordController.text);

    if (emailError != null) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(emailError)));
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (passwordError != null) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(passwordError)));
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeNavigationPage()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      print('Login error: $e');
      String errorMessage = ValidationHelper.handleAuthException(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: ColorConfig.gradientBrand),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            color: ColorConfig.onPrimaryColor,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Welcome Back. Enter your email and Password to sign in",
                          style: TextStyle(
                            color: ColorConfig.onPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        AuthTextField(
                          keyboardType: TextInputType.emailAddress,
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
                          icon: Icons.visibility,
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [],
                        ),
                        const SizedBox(height: 48),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : AuthButton(
                                buttonText: "Sign In", onPressed: _login),
                        const SizedBox(height: 16),
                        SupportText(
                          firstText: "Don't have account? ",
                          secondText: "Sign up",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeNavigationPage(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    "Continue without login",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
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
