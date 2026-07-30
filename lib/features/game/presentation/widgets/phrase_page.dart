import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/features/home/model/phrase_model.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../i18n/strings.g.dart';

class PhrasePage extends StatelessWidget {
  final PhraseModel phrase;
  final bool isHost;

  const PhrasePage({super.key, required this.phrase, required this.isHost});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),

        Text(
          t.gamePage.roundPhrase,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.marcellus,
            fontWeight: FontWeight.w500,
            fontSize: AppFontSize.bodyLarge,
            color: AppColors.gray200,
          ),
        ),

        Column(
          children: [
            Text(
              '"${phrase.text}"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.display,
                color: AppColors.white,
              ),
            ),

            const SizedBox(height: 24),

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
            SvgPicture.asset(
              'assets/images/long_press.svg',
              width: 46,
              colorFilter: const ColorFilter.mode(
                AppColors.gray200,
                BlendMode.srcIn,
              ),
            ),
            Text(
              t.gamePage.tapAndHoldToSeeNumber,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppFonts.marcellus,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSize.bodyLargeX,
                color: AppColors.gray200,
              ),
            ),
          ],
        ),

        isHost
            ? CustomElevatedButton(
                text: t.gamePage.sortChoices,
                backgroundColor: AppColors.white,
                fontColor: AppColors.black,
                onPressed: () => context.pushNamed(AppRoutes.ordering),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
