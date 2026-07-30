import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/theme/app_font_size.dart';
import 'package:phroneo/core/theme/app_fonts.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/features/auth/presentation/controllers/auth_controller.dart';
import 'package:phroneo/features/home/presentation/widgets/custom_elevated_icon_button.dart';

class LoginPage extends StatefulWidget {
  final AuthController authController;

  const LoginPage({super.key, required this.authController});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final authController = widget.authController;

    return AnimatedBuilder(
      animation: authController,
      builder: (context, _) {
        return authController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                backgroundColor: AppColors.background,
                appBar: const CustomAppBar(showBackButton: false),
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
                          strings.app_name,
                          style: TextStyle(
                            fontFamily: AppFonts.cinzel,
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSize.titleMedium,
                            color: AppColors.primaryColor,
                          ),
                        ),

                        const SizedBox(height: 54),

                        Text(
                          strings.privacy_policy,
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
                          labelText: context.l10n.login_google,
                          onPressed: () {
                            authController.login(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}