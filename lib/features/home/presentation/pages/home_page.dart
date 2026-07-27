import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/features/home/presentation/widgets/create_match_menu_bottom_sheet.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(showAccount: true, showBackButton: false),
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(mainAxisSize: MainAxisSize.min,
            children: [

              SvgPicture.asset('assets/images/logo_phroneo.svg', width: 80),

              const SizedBox(height: 12),

              CustomTitle(text: context.l10n.welcome_message),

              const SizedBox(height: 32),

              CustomElevatedButton(
                  text: context.l10n.create_match,
                  onPressed: () {
                    CreateMatchMenuBottomSheet.showCreateMatchMenuBottomSheet(context);
                  }
              ),

              const SizedBox(height: 12),

              CustomElevatedButton(
                  text: context.l10n.join_match,
                  onPressed: () async {
                    final String? scannedCode = await context.pushNamed<String>(AppRoutes.qrScanner);

                    if (scannedCode != null) {
                      print('Tentando entrar na sala: $scannedCode');

                      // TODO -> chamar controller
                      // tela de loading, passar o código para a tela anterior
                      // ela vai pegar o código, passar para o MatchController
                      // dai ele vai atualizar o firebase e passar o usuário
                      // para a tela para jogar, já com a frase
                    } else {
                      // Cai aqui se o usuário apertar o botão de voltar do celular
                      // sem ler nenhum QR Code
                      print('Usuário cancelou a leitura.');
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}