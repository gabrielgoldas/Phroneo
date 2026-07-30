import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';
import 'package:phroneo/i18n/strings.g.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/widgets/custom_loading.dart';

class RoomLobbyPage extends StatefulWidget {
  final MatchController matchController;
  final String? roomCode;

  const RoomLobbyPage({
    super.key,
    required this.roomCode,
    required this.matchController,
  });

  @override
  State<RoomLobbyPage> createState() => _RoomLobbyPageState();
}

class _RoomLobbyPageState extends State<RoomLobbyPage> {
  Widget _numberOfPlayers() {
    final match = widget.matchController.currentMatch;
    if (match == null) return Text('');
    if (match.playersIds.length >= match.maxPlayers) {
      return Text(
        t.roomLobby.allPlayersJoinedMatch,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppFonts.cormorantInfant,
          fontWeight: FontWeight.w500,
          fontSize: AppFontSize.titleSmall,
          color: AppColors.black,
        ),
      );
    } else {
      return Column(
        children: [
          customLoading(color: AppColors.primaryColor),
          Text(
            t.roomLobby.playersJoined(
              current: match.playersIds.length,
              max: match.maxPlayers,
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.cormorantInfant,
              fontWeight: FontWeight.w500,
              fontSize: AppFontSize.titleSmall,
              color: AppColors.black,
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final matchController = widget.matchController;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      body: ListenableBuilder(
        listenable: matchController,
        builder: (context, child) {
          final match = matchController.currentMatch;

          if (match == null) {
            return Center(child: customLoading());
          }

          return matchController.isHost
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox.shrink(),

                        Text(
                          t.roomLobby.shareQrCodeInstruction,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AppFonts.cormorantInfant,
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSize.titleLarge,
                            color: AppColors.black,
                          ),
                        ),

                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundClearer,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: QrImageView(
                                data: widget.roomCode ?? '',
                                version: QrVersions
                                    .auto, // Calcula automaticamente a densidade do QR
                                size: 180.0,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            _numberOfPlayers(),

                            const SizedBox(height: 24),

                            if (matchController.allPlayersJoinMatch())
                              CustomElevatedButton(
                                text: t.roomLobby.startButton,
                                onPressed: () async {
                                  await matchController.startMatch();
                                  if (!context.mounted) return;
                                  context.pushNamed(AppRoutes.game);
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox.shrink(),

                        Column(
                          children: [
                            Text(
                              t.roomLobby.wait,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppFonts.cormorantInfant,
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSize.displaySmall,
                                color: AppColors.black,
                              ),
                            ),

                            Text(
                              t.roomLobby.playersStillJoining,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppFonts.cormorantInfant,
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSize.titleMedium,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),

                        _numberOfPlayers(),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
