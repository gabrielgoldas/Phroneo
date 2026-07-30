import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/features/game/presentation/widgets/phrase_page.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/number_page.dart';

class GamePage extends StatefulWidget {
  final MatchController matchController;

  const GamePage({ super.key, required this.matchController });

  @override
  State<StatefulWidget> createState() => _GamePage();
}

class _GamePage extends State<GamePage> {

  bool showNumberPage = false;
  bool _isNavigating = false;

  void togglePageToShow() {
    setState(() {
      showNumberPage = !showNumberPage;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.matchController.addListener(_onMatchStateChanged);
  }

  void _onMatchStateChanged() {
    if (
        widget.matchController.currentMatch?.status == StatusMatch.finishedRound
        && !widget.matchController.isHost
        && !_isNavigating
    ) {
      _isNavigating = true;
      if (mounted) context.goNamed(AppRoutes.roundResult);
    }
  }

  @override
  void dispose() {
    widget.matchController.removeListener(_onMatchStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myColor = Color(widget.matchController.getMyColor());
    final matchController = widget.matchController;

    final backgroundColor = showNumberPage
        ? HSLColor.fromColor(myColor).withLightness(0.35).toColor()
        : myColor;

    const transitionDuration = Duration(milliseconds: 500);

    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.easeInOut,
      color: backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          fontColor: AppColors.background,
          showBackButton: false,
          backgroundColor: Colors.transparent,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPressStart: (_) => togglePageToShow(),
          onLongPressEnd: (_) => togglePageToShow(),
          child: SizedBox.expand(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 54.0,
                ),
                child: ListenableBuilder(
                  listenable: matchController,
                  builder: (context, child) {
                    if (matchController.currentMatch == null) {
                      return const CircularProgressIndicator();
                    }

                    return AnimatedSwitcher(
                      duration: transitionDuration,
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: showNumberPage
                          ? NumberPage(
                              key: ValueKey('number_page'),
                              number:  matchController.getSecretNumber(),
                          )
                          : PhrasePage(
                              key: ValueKey('phrase_page'),
                              phrase: matchController.currentMatch!.currentPhrase,
                              isHost: matchController.isHost,
                          ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
