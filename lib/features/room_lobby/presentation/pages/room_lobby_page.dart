import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';

class RoomLobbyPage extends StatelessWidget {
  const RoomLobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              const SizedBox.shrink(),

              Column(
                children: [
                  Text(
                    strings.shareQrCodeInstruction,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.cormorantInfant,
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSize.titleLarge,
                      color: AppColors.black,
                    ),
                  ),

                  Image.asset('assets/images/qr_code.png', width: 180),
                ],
              ),

              Column(
                children: [
                  Text(
                    strings.qrCodeConfirmationInstruction,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.cormorantInfant,
                      fontWeight: FontWeight.w500,
                      fontSize: AppFontSize.bodyLargeX,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: 24),

                  CustomElevatedButton(
                      text: strings.startButton,
                      onPressed: () => context.pushNamed(AppRoutes.game)
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