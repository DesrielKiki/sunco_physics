import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
        hintText: widget.hintText,
        labelText: widget.label,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: ColorConfig.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : Icon(
                widget.icon,
                color: ColorConfig.primaryColor,
              ),
        hintStyle: const TextStyle(color: ColorConfig.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
