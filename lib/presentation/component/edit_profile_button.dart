import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class EditProfileButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final Color buttonColor;
  final Function()? onPressed;

  const EditProfileButton({
    super.key,
    this.buttonColor = ColorConfig.primaryColor,
    required this.buttonText,
    required this.buttonIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Memastikan tombol memenuhi lebar layar
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Mengatur ikon di kanan
            children: [
              Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                buttonIcon,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
