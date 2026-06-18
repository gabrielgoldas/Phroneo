import 'package:flutter/cupertino.dart';
import 'package:phroneo/features/how_to_play/domain/entities/onboarding_page_data.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';

class TutorialPage extends StatelessWidget {
  final OnboardingPageData page;

  const TutorialPage({
    super.key,
    required this.page
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              page.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppFontSize.display,
                fontFamily: AppFonts.cinzel,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor
              ),
            ),

            const SizedBox(height: 24),

            Text(
              page.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppFontSize.bodyLargeX,
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
    );
  }
}