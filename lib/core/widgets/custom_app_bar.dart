import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../features/auth/presentation/widgets/profile_menu_bottom_sheet.dart';
import '../theme/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showAccount;
  final Color backgroundColor;
  final Color fontColor;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.showAccount = false,
    this.backgroundColor = AppColors.background,
    this.fontColor = AppColors.primaryColor,
    this.showBackButton = true
  });

  @override
  Widget build(BuildContext context) {
    final color = fontColor;
    return AppBar(
      actions: [
        if (showAccount)
          IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () =>
                  ProfileMenuBottomSheet.showProfileMenuBottomSheet(context),
          ),
      ],
      backgroundColor: backgroundColor,
      centerTitle: true,
      title: Text(
        context.l10n.app_name,
        style: TextStyle(
          fontFamily: AppFonts.cinzel,
          fontSize: AppFontSize.bodySmall,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryColor,
            size: 20,
          ),
          onPressed: () => context.pop()
      ) : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
