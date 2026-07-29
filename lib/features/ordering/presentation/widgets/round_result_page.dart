import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/core/theme/app_font_size.dart';
import 'package:phroneo/core/theme/app_fonts.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_outlined_button.dart';

class RoundResultPage extends StatefulWidget {
  final MatchController matchController;

  const RoundResultPage({super.key, required this.matchController});

  @override
  State<RoundResultPage> createState() => _RoundResultPageState();
}

class _RoundResultPageState extends State<RoundResultPage> {
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    widget.matchController.addListener(_onMatchStateChanged);
  }

  void _onMatchStateChanged() {
    final status = widget.matchController.currentMatch?.status;

    if (status == StatusMatch.playing && !_isNavigating) {
      _isNavigating = true;
      if (mounted) context.goNamed(AppRoutes.game);
    }

    if (status == StatusMatch.finished && !_isNavigating) {
      _isNavigating = true;
      if (mounted) context.goNamed(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    widget.matchController.removeListener(_onMatchStateChanged);
    super.dispose();
  }

  bool? _isVictory() {
    final match = widget.matchController.currentMatch;
    if (match != null && match.lastRoundVictory != null) {
      return match.lastRoundVictory!;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final bool isVictory = _isVictory() ?? false;

    return Scaffold(
      appBar: CustomAppBar(
        showAccount: false,
        showBackButton: false,
        backgroundColor: isVictory ? AppColors.background : AppColors.black,
        fontColor: isVictory ? AppColors.primaryColor : AppColors.background,
      ),
      backgroundColor: isVictory ? AppColors.background : AppColors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.00),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              widget.matchController.isHost
                  ? const SizedBox.shrink()
                  : const SizedBox(),

              Column(
                children: [
                  Text(
                    isVictory
                        ? strings.congratulationsTitle
                        : strings.tooBadTitle,
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
                    isVictory ? strings.victoryMessage : strings.defeatMessage,
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

              widget.matchController.isHost
                  ? Column(
                      children: [
                        CustomOutlinedButton(
                          text: strings.leave,
                          fontColor: isVictory
                              ? AppColors.primaryColor
                              : AppColors.gray200,
                          onPressed: () async {
                            final leavingSuccess = await widget.matchController
                                .leaveAndCloseCurrentMatch();
                            if (leavingSuccess && context.mounted) {
                              context.goNamed(AppRoutes.home);
                            }
                          },
                        ),

                        CustomElevatedButton(
                          text: strings.newRoundButton,
                          backgroundColor: isVictory
                              ? AppColors.primaryColor
                              : AppColors.white,
                          fontColor: isVictory
                              ? AppColors.white
                              : AppColors.primaryColor,
                          onPressed: () async {
                            await widget.matchController.newRoundMatch();
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
  }
}
