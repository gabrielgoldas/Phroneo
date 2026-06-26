import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';

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
                title: const Text('Meu perfil'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help_outline_outlined),
                title: const Text('Como jogar'),
                onTap: () {
                  context.goNamed(AppRoutes.onboarding);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Sair'),
                onTap: () {
                  context.goNamed(AppRoutes.login);
                },
              ),
            ],
          ).toList(), // Precisa do .toList() no final!
        ),
      ),
    );
  }
}
