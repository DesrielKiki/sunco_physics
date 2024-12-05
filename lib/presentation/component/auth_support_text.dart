import 'package:flutter/material.dart';
import 'package:sunco_physics/presentation/theme/color_config.dart';

class SupportText extends StatefulWidget {
  final String firstText;
  final String secondText;
  final Function()? onPressed;

  const SupportText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onPressed,
  });

  @override
  State<SupportText> createState() => _SupportTextState();
}

class _SupportTextState extends State<SupportText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.firstText,
          style: const TextStyle(
            color: ColorConfig.onPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: widget.onPressed,
          child: Text(
            widget.secondText,
            style: const TextStyle(
              color: ColorConfig.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
