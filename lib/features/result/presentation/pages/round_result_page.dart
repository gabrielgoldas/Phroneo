import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/theme/app_font_size.dart';
import 'package:phroneo/core/theme/app_fonts.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/i18n/strings.g.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_outlined_button.dart';
import '../../../home/bloc/match_bloc.dart';
import '../../../home/bloc/match_event.dart';
import '../../../home/bloc/match_state.dart';

class RoundResultPage extends StatefulWidget {
  const RoundResultPage({super.key});

  @override
  State<RoundResultPage> createState() => _RoundResultPageState();
}

class _RoundResultPageState extends State<RoundResultPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MatchBloc, MatchState>(
      listenWhen: (previous, current) {
        final prevStatus = previous.currentMatch?.status;
        final currentStatus = current.currentMatch?.status;

        return prevStatus != currentStatus;
      },
      listener: (context, state) async {
        final status = state.currentMatch?.status;

        if (status == StatusMatch.playing) {
          context.goNamed(AppRoutes.game);
        }

        if (status == StatusMatch.finished) {
          context.goNamed(AppRoutes.home);
        }
      },
      child: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          final bloc = context.read<MatchBloc>();
          final bool isVictory = state.currentMatch?.lastRoundVictory ?? false;

          return Scaffold(
            appBar: CustomAppBar(
              showAccount: false,
              showBackButton: false,
              backgroundColor: isVictory
                  ? AppColors.background
                  : AppColors.black,
              fontColor: isVictory
                  ? AppColors.primaryColor
                  : AppColors.background,
            ),
            backgroundColor: isVictory ? AppColors.background : AppColors.black,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.00),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    bloc.isHost ? const SizedBox.shrink() : const SizedBox(),

                    Column(
                      children: [
                        Text(
                          isVictory
                              ? t.orderingPage.congratulationsTitle
                              : t.orderingPage.tooBadTitle,
                          style: TextStyle(
                            fontFamily: AppFonts.cinzel,
                            fontSize: AppFontSize.bodyLarge,
                            fontWeight: FontWeight.w600,
                            color: isVictory
                                ? AppColors.primaryColor
                                : AppColors.background,
                          ),
                        ),

                        Text(
                          isVictory
                              ? t.orderingPage.victoryMessage
                              : t.orderingPage.defeatMessage,
                          style: TextStyle(
                            fontFamily: AppFonts.cinzel,
                            fontSize: AppFontSize.display,
                            fontWeight: FontWeight.bold,
                            color: isVictory
                                ? AppColors.primaryColor
                                : AppColors.background,
                          ),
                        ),

                        const SizedBox(height: 24.0),

                        isVictory
                            ? SvgPicture.asset(
                                'assets/images/logo_phroneo_white.svg',
                                width: 180,
                                colorFilter: ColorFilter.mode(
                                  isVictory
                                      ? AppColors.primaryColor
                                      : AppColors.gray200,
                                  BlendMode.srcIn,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),

                    bloc.isHost
                        ? Column(
                            children: [
                              CustomOutlinedButton(
                                text: t.orderingPage.leave,
                                fontColor: isVictory
                                    ? AppColors.primaryColor
                                    : AppColors.gray200,
                                onPressed: () async {
                                  bloc.add(LeaveAndCloseMatch());
                                },
                              ),

                              CustomElevatedButton(
                                text: t.orderingPage.newRoundButton,
                                backgroundColor: isVictory
                                    ? AppColors.primaryColor
                                    : AppColors.white,
                                fontColor: isVictory
                                    ? AppColors.white
                                    : AppColors.primaryColor,
                                onPressed: () async {
                                  context.read<MatchBloc>().add(NewRound());
                                },
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
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
