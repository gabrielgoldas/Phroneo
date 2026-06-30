import 'package:flutter/cupertino.dart';
import 'package:phroneo/core/widgets/custom_title.dart';
import 'package:phroneo/features/onboarding/domain/entities/onboarding_page_data.dart';

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

            CustomTitle(text: page.title),

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