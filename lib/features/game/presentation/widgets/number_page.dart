import 'package:flutter/cupertino.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../i18n/strings.g.dart';

class NumberPage extends StatelessWidget {
  final int number;

  const NumberPage({ super.key, required this.number });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Text(
          t.gamePage.yourNumberIs,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.marcellus,
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.titleMedium,
            color: AppColors.gray200,
          ),
        ),

        Text(
          number.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.cormorantInfant,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.displayNumber,
            color: AppColors.white,
            height: 0.9,
          ),
        ),
      ],
    );
  }
}