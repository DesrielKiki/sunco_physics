import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class AuthButton extends StatefulWidget {
  final String buttonText;
  final Function()? onPressed;

  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: ColorConfig.darkBlue,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.buttonText,
        style: const TextStyle(
            color: ColorConfig.onPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
