import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';
import 'package:phroneo/features/auth/presentation/controllers/auth_controller.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../service/auth_service.dart';

class ProfileMenuBottomSheet extends StatelessWidget {
  final AuthController authController;

  const ProfileMenuBottomSheet({ super.key, required this.authController });

  static void showProfileMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ProfileMenuBottomSheet(
        authController: getIt<AuthController>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final authService = getIt<AuthService>();
    final photoUrl = authService.currentUser?.photoURL;
    final displayName = authService.currentUser?.displayName;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const SizedBox(height: 8),

            CircleAvatar(
              radius: 48,
              backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
              child: photoUrl == null ? Icon(Icons.person, size: 48) : null,
            ),

            const SizedBox(height: 12),

            Text(
              displayName ?? "Anônimo",
              style: TextStyle(
              fontFamily: AppFonts.cinzel,
              fontSize: AppFontSize.bodyLarge,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
              )
            ),

            const SizedBox(height: 24),

            ...ListTile.divideTiles(
              context: context,
              color: Colors.transparent,
              tiles: [
                ListTile(
                  leading: const Icon(Icons.help_outline_outlined),
                  title: Text(strings.how_to_play),
                  onTap: () {
                    context.pop();
                    context.goNamed(AppRoutes.onboarding);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: Text(strings.exit),
                  onTap: () {
                    context.pop();
                    authController.logout();
                  },
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}