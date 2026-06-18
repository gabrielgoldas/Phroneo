import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';
import '../theme/app_font_size.dart';
import '../theme/app_fonts.dart';

class CustomTitle extends StatelessWidget {
  final String text;

  const CustomTitle({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: AppFontSize.display,
          fontFamily: AppFonts.cinzel,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor
      ),
    );
  }
}