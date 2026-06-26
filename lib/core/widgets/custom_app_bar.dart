import 'package:flutter/material.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../features/login/presentation/widgets/profile_menu_bottom_sheet.dart';
import '../theme/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showAccount;
  final Color backgroundColor;
  final Color textColor;

  const CustomAppBar({
    super.key,
    this.showAccount = false,
    this.backgroundColor = AppColors.background,
    this.textColor = AppColors.primaryColor
  });

  @override
  Widget build(BuildContext context) {
    final color = textColor;
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
