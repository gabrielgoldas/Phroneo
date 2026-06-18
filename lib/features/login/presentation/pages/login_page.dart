import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/theme/app_font_size.dart';
import 'package:phroneo/core/theme/app_fonts.dart';
import 'package:phroneo/core/widgets/custom_header.dart';
import 'package:phroneo/features/home/presentation/widgets/custom_elevated_icon_button.dart';
import 'package:phroneo/l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: const CustomHeader(),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/logo_phroneo.svg', width: 180),

              const SizedBox(height: 12),

              Text(
                strings.appName,
                style: TextStyle(
                  fontFamily: AppFonts.cinzel,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.titleMedium,
                  color: AppColors.primaryColor,
                ),
              ),

              const SizedBox(height: 54),

              Text(
                strings.privacyPolicy,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppFonts.cormorantInfant,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.bodyMedium,
                  color: AppColors.black,
                ),
              ),

              const SizedBox(height: 24),

              CustomElevatedIconButton(
                backgroundColor: AppColors.white,
                textColor: AppColors.black,
                filePath: 'assets/icons/google_icon.svg',
                labelText: strings.googleLogin,
                onPressed: () {
                  context.go('/onboarding');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
