import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/theme/app_font_size.dart';
import 'package:phroneo/core/theme/app_fonts.dart';
import 'package:phroneo/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: Text(
          strings.appName,
          style: const TextStyle(
              fontFamily: AppFonts.cinzel,
              fontSize: AppFontSize.bodySmall,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor
          ),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/logo_phroneo.svg',
                width: 180,
              ),

              const SizedBox(height: 12),

              Text(
                strings.appName,
                style: TextStyle(
                    fontFamily: AppFonts.cinzel,
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.titleMedium,
                    color: AppColors.primaryColor
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
                    color: AppColors.black
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                  onPressed: () { context.go('/onboarding'); },
                  icon: SvgPicture.asset(
                    'assets/icons/google_icon.svg',
                    width: 24,
                    height: 24,
                  ),
                  label: Text(AppLocalizations.of(context)!.googleLogin),
              )
            ],
          ),
          ),
      ),
    );
  }
}