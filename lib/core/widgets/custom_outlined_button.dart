import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_font_size.dart';
import '../theme/app_fonts.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final Color fontColor;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    super.key,
    this.fontColor = AppColors.primaryColor,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton (
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: BorderSide(
          color: Colors.transparent,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: AppFonts.cinzel,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.bodySmall,
            color: fontColor,
            decoration: TextDecoration.underline
        ),
      ),
    );
  }
}