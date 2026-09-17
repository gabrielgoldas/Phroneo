import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/features/home/bloc/match_event.dart';
import 'package:phroneo/i18n/strings.g.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../home/bloc/match_bloc.dart';
import '../../../home/bloc/match_state.dart';
import '../../../home/model/match_model.dart';

class RoomLobbyPage extends StatefulWidget {
  final String? roomCode;

  const RoomLobbyPage({super.key, required this.roomCode});

  @override
  State<RoomLobbyPage> createState() => _RoomLobbyPageState();
}

class _RoomLobbyPageState extends State<RoomLobbyPage> {
  Widget _numberOfPlayers(MatchModel match) {
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
    return BlocListener<MatchBloc, MatchState>(
      listenWhen: (previous, current) {
        return previous.currentMatch?.status != current.currentMatch?.status;
      },
      listener: (context, state) {
        if (state.currentMatch?.status == StatusMatch.playing) {
          context.pushNamed(AppRoutes.game);
        }
      },
      child: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: customLoading(width: 100));
          }

          final match = state.currentMatch;

          if (match == null) {
            return Center(child: customLoading());
          }

          final matchBloc = context.read<MatchBloc>();

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: const CustomAppBar(),
            body: matchBloc.isHost
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
                              _numberOfPlayers(match),

                              const SizedBox(height: 24),

                              if (matchBloc.allPlayersJoinMatch)
                                CustomElevatedButton(
                                  text: t.roomLobby.startButton,
                                  onPressed: () async {
                                    matchBloc.add(StartMatch());
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

                          _numberOfPlayers(match),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
