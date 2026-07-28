import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/theme/app_font_size.dart';
import 'package:phroneo/core/theme/app_fonts.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';

import '../../../../core/widgets/custom_outlined_button.dart';

class RoundResultDialog extends StatelessWidget {
  final bool everyoneWon;

  const RoundResultDialog({ super.key, required this.everyoneWon });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Scaffold(
      appBar: const CustomAppBar(
        showAccount: false,
        showBackButton: false,
        backgroundColor: Colors.transparent,
        fontColor: AppColors.background,
      ),
      backgroundColor: AppColors.bgTransparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.00),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              const SizedBox.shrink(),

              Column(
                children: [
                  Text(
                    everyoneWon ? strings.congratulationsTitle : strings.tooBadTitle,
                    style: TextStyle(
                        fontFamily: AppFonts.cinzel,
                        fontSize: AppFontSize.bodyLarge,
                        color: AppColors.gray100
                    ),
                  ),

                  Text(
                    everyoneWon ? strings.victoryMessage : strings.defeatMessage,
                    style: TextStyle(
                        fontFamily: AppFonts.cinzel,
                        fontSize: AppFontSize.titleLarge,
                        color: AppColors.white
                    ),
                  ),

                  const SizedBox(height: 24.0),

                  everyoneWon
                  ? SvgPicture.asset(
                      'assets/images/logo_phroneo_white.svg',
                      width: 180,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                  ) : const SizedBox.shrink()


                ],
              ),

              Column(
                children: [

                  CustomOutlinedButton(
                      text: strings.exit,
                      fontColor: AppColors.background,
                      onPressed: () => context.goNamed(AppRoutes.home)
                  ),

                  CustomElevatedButton(
                      text: strings.newRoundButton,
                      backgroundColor: AppColors.background,
                      fontColor: AppColors.black,
                      onPressed: () => context.goNamed(AppRoutes.roomLobby)
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}