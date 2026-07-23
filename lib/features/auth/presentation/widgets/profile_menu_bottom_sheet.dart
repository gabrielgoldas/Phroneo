import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';

class ProfileMenuBottomSheet extends StatelessWidget {
  const ProfileMenuBottomSheet({super.key});

  static void showProfileMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const ProfileMenuBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ListTile.divideTiles(
            context: context,
            color: Colors.transparent,
            tiles: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(strings.profile),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help_outline_outlined),
                title: Text(strings.how_to_play),
                onTap: () {
                  context.goNamed(AppRoutes.onboarding);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: Text(strings.exit),
                onTap: () {
                  context.goNamed(AppRoutes.login);
                },
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}
