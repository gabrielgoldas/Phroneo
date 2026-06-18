import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/theme/app_font_size.dart';
import 'package:phroneo/core/widgets/custom_outlined_button.dart';
import 'package:phroneo/features/how_to_play/domain/entities/onboarding_page_data.dart';
import 'package:phroneo/features/how_to_play/presentation/widgets/tutorial_page.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../l10n/app_localizations.dart';

class HowToPlayPage extends StatefulWidget {
  const HowToPlayPage({super.key});

  @override
  State<HowToPlayPage> createState() => _HowToPlayPageState();
}

class _HowToPlayPageState extends State<HowToPlayPage> {

  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Column(
        children: [

          Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,

                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder: (_, index) {
                  return TutorialPage(page: onboardingPages[index],
                  );
                },
              )
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                onboardingPages.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: currentPage == index ? 12 : 8,
                  height: currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index ? AppColors.black : AppColors.gray500
                  ),
                )
            ),
          ),

          const SizedBox(height: 24),

          currentPage == onboardingPages.length - 1 ?
          CustomElevatedButton(
            text: AppLocalizations.of(context)!.ready,
            onPressed: () {},
          ) :
          CustomElevatedButton(
            text: AppLocalizations.of(context)!.next,
            onPressed: () {
              if (currentPage < onboardingPages.length - 1) {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut
                );
              }
            },
          ),

          (currentPage > 0) ?
            CustomOutlinedButton(
              text: AppLocalizations.of(context)!.previous,
              onPressed: () {
                if (currentPage > 0) {
                  _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut
                  );
                }
              }
            )
            :
          const SizedBox.shrink(),

          const SizedBox(height: 32),

        ],
      ),
    );
  }
}