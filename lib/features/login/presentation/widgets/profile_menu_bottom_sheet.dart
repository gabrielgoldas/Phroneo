import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileMenuBottomSheet extends StatelessWidget {
  const ProfileMenuBottomSheet({ super.key });

  static void showProfileMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => const ProfileMenuBottomSheet()
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Meu perfil'),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.help_outline_outlined),
              title: const Text('Como jogar'),
              onTap: () { context.go('/onboarding'); },
            ),

            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Sair'),
              onTap: () { context.go('/'); },
            ),
          ],

        )
    );
  }
}