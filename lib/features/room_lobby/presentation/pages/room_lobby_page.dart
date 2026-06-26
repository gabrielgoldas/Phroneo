import 'package:flutter/material.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/core/widgets/custom_header.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';

class RoomLobbyPage extends StatelessWidget {
  const RoomLobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomHeader(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset('assets/images/qr_code.png', width: 180),

              const SizedBox(height: 12),

              Text(
              "Mostre o QR Code para seus amigos jogarem com você!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.cormorantInfant,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.bodyLargeX,
                  color: AppColors.black,
                ),
              ),

              const SizedBox(height: 54),

              Text(
                "Todos leram o QR Code? \nSe sim, então vamos lá!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.cormorantInfant,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.bodyLargeX,
                  color: AppColors.black,
                ),
              ),
              
              CustomElevatedButton(
                  text: "Iniciar",
                  onPressed: () {}
              )

            ],
          ),
        ),
      ),
    );
  }
}