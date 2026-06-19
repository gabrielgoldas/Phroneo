import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/core/widgets/custom_header.dart';
import 'package:phroneo/features/login/presentation/widgets/create_match_menu_bottom_sheet.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

  final strings     = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const CustomHeader(showAccount: true),
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(mainAxisSize: MainAxisSize.min,
            children: [

              SvgPicture.asset('assets/images/logo_phroneo.svg', width: 80),

              const SizedBox(height: 12),

              CustomTitle(text: strings.letsPlay),

              const SizedBox(height: 32),

              CustomElevatedButton(
                  text: "Criar uma partida",
                  onPressed: () {
                    CreateMatchMenuBottomSheet.showCreateMatchMenuBottomSheet(context);
                  }
              ),

              const SizedBox(height: 12),

              CustomElevatedButton(
                  text: "Entrar na partida",
                  onPressed: () {}
              ),
            ],
          ),
        ),
      ),
    );
  }
}