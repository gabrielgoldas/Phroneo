import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phroneo/core/widgets/custom_header.dart';
import 'package:phroneo/features/home/presentation/widgets/custom_elevated_icon_button.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool   isHost          = true;
  int     selectedPlayers = 2;
  Timer?  _timer;

  void startIncrement() {
    _timer = Timer.periodic(
        const Duration(milliseconds: 100),
        (_) {
          if (selectedPlayers < 20) {
            setState(() => selectedPlayers++);
          }
        }
    );
  }

  void startDecrement() {
    _timer = Timer.periodic(
        const Duration(milliseconds: 100),
            (_) {
          if (selectedPlayers > 2) {
            setState(() => selectedPlayers--);
          }
        }
    );
  }

  void stop() => _timer?.cancel();

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

              Text(
                "Você vai ser o organizador da partida?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppFontSize.titleSmall,
                  fontFamily: AppFonts.cormorantInfant,
                  fontWeight: FontWeight.w600,
                ),
              ),

              RadioGroup<bool>(
                groupValue: isHost,
                  onChanged: (value) {
                    setState(() {
                      isHost = value!;
                    });
                  },
                  child: Column(
                    children: [
                      RadioListTile<bool>(
                        value: true,
                        title: const Text(
                          "Sim",
                          style: TextStyle(
                            fontSize: AppFontSize.bodyLargeX,
                            fontFamily: AppFonts.cormorantInfant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      RadioListTile<bool>(
                        value: false,
                        title: const Text(
                          "Não",
                          style: TextStyle(
                          fontSize: AppFontSize.bodyLargeX,
                          fontFamily: AppFonts.cormorantInfant,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                      )
                    ],
                  )
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isHost == true ? 'Quantas pessoas vão jogar?' : 'Abrir câmera para ler o QR Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppFontSize.titleSmall,
                      fontFamily: AppFonts.cormorantInfant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  (isHost == true) ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onLongPressStart: (_) => startDecrement(),
                        onLongPressEnd:   (_) => stop(),
                        child: IconButton(
                          onPressed: selectedPlayers > 2
                              ? () => setState(() => selectedPlayers--)
                              : null,
                          icon: const Icon(Icons.remove),
                        ),
                      ),

                      Text(
                        '$selectedPlayers',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GestureDetector(
                        onLongPressStart: (_) => startIncrement(),
                        onLongPressEnd:   (_) => stop(),
                        child: IconButton(
                          onPressed: selectedPlayers < 20
                              ? () => setState(() => selectedPlayers++)
                              : null,
                          icon: const Icon(Icons.add),
                        ),
                      )

                    ],
                  ) :
                  CustomElevatedIconButton(
                      icon: Icons.qr_code_scanner,
                      labelText: "Entrar na sala",
                      onPressed: () {}
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}