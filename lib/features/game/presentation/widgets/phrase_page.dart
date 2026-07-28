import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/model/phrase_model.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';

class PhrasePage extends StatelessWidget {
  final PhraseModel phrase;

  const PhrasePage({ super.key, required this.phrase });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),

        Column(
          children: [
            Text(
              context.l10n.roundPhrase,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.bodyLarge,
                color: AppColors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              phrase.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.titleLargeX,
                color: AppColors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              phrase.biggestNumber,
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.titleSmall,
                color: AppColors.white,
              ),
            ),

            Text(
              phrase.smallestNumber,
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.titleSmall,
                color: AppColors.white,
              ),
            ),
          ],
        ),

        Column(
          children: [
            SvgPicture.asset('assets/images/long_press.svg', width: 48),
            Text(
              context.l10n.tapAndHoldToSeeNumber,
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
            text: context.l10n.sortChoices,
            backgroundColor: AppColors.white,
            fontColor: AppColors.black,
            onPressed: () => context.pushNamed(AppRoutes.ordering)
        )
      ],
    );
  }
}