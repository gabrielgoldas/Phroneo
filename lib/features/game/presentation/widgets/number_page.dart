import 'package:flutter/cupertino.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';

class NumberPage extends StatelessWidget {
  const NumberPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Text(
          "Seu número é:",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.cormorantInfant,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.titleMedium,
            color: AppColors.background,
          ),
        ),

        Text(
          "70",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.cormorantInfant,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.displayNumber,
            color: AppColors.background,
            height: 0.9,
          ),
        ),
      ],
    );
  }
}