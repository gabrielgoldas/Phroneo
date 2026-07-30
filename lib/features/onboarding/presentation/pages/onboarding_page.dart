import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/core/widgets/custom_outlined_button.dart';
import 'package:phroneo/features/onboarding/presentation/widgets/tutorial_page.dart';
import 'package:phroneo/features/onboarding/repository/onboarding_repository.dart';
import 'package:phroneo/i18n/strings.g.dart';

import '../../../../core/widgets/custom_elevated_button.dart';

class Onboarding extends StatefulWidget {
  final OnboardingRepository _onboardingRepository;

  const Onboarding({ super.key, required this._onboardingRepository });

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  final PageController _pageController = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allOnboardingData = widget._onboardingRepository.allOnboardingData;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(showBackButton: false),
      body: Column(
        children: [

          Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: allOnboardingData.length,

                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder: (_, index) {
                  return TutorialPage(page: allOnboardingData[index],
                  );
                },
              )
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                allOnboardingData.length,
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

          (currentPage > 0) ?
          CustomOutlinedButton(
              text: t.onboardingPage.previous,
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

          currentPage == allOnboardingData.length - 1 ?
          CustomElevatedButton(
            text: t.onboardingPage.ready,
            onPressed: () {
              context.goNamed(AppRoutes.home);
              },
          ) :
          CustomElevatedButton(
            text: t.onboardingPage.next,
            onPressed: () {
              if (currentPage < allOnboardingData.length - 1) {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut
                );
              }
            },
          ),

          const SizedBox(height: 32),

        ],
      ),
    );
  }
}