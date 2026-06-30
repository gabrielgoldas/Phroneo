import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';

class PhrasePage extends StatelessWidget {
  const PhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),

        Column(
          children: [
            Text(
              "Frase da rodada:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.bodyLarge,
                color: AppColors.background,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "\"Itens essenciais para levar em uma ilha deserta\"",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.titleLargeX,
                color: AppColors.background,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "1: Menos essencial",
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.titleSmall,
                color: AppColors.background,
              ),
            ),

            Text(
              "100: Mais essencial",
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.titleSmall,
                color: AppColors.background,
              ),
            ),
          ],
        ),

        Column(
          children: [
            SvgPicture.asset('assets/images/long_press.svg', width: 48),
            Text(
              "Toque e segure para ver seu número",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.titleSmall,
                color: AppColors.background,
              ),
            ),
          ],
        ),

        CustomElevatedButton(
            text: 'Ordenar Escolhas',
            backgroundColor: AppColors.background,
            fontColor: AppColors.black,
            onPressed: () => context.goNamed(AppRoutes.ordering)
        )
      ],
    );
  }
}
