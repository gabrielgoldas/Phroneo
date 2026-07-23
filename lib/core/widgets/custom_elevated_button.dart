import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color fontColor;

  const CustomElevatedButton({
    super.key,
    this.backgroundColor = AppColors.primaryColor,
    this.fontColor = AppColors.background,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: AppFonts.cinzel,
            fontWeight: FontWeight.bold,
            color: fontColor
        ),
      ),
    );
  }
}