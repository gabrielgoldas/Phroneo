import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../l10n/app_localizations.dart';
import '../../features/login/presentation/widgets/profile_menu_bottom_sheet.dart';
import '../theme/app_fonts.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool showAccount;

  const CustomHeader({super.key, this.showAccount = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        ?showAccount
            ? IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () =>
                    ProfileMenuBottomSheet.showProfileMenuBottomSheet(context),
              )
            : null,
      ],
      backgroundColor: AppColors.background,
      centerTitle: true,
      title: Text(
        AppLocalizations.of(context)!.appName,
        style: const TextStyle(
          fontFamily: AppFonts.cinzel,
          fontSize: AppFontSize.bodySmall,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
