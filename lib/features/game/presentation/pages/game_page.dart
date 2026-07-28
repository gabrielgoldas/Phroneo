import 'package:flutter/material.dart';
import 'package:phroneo/core/di/injection.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/features/game/presentation/widgets/phrase_page.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/number_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({ super.key });

  @override
  State<StatefulWidget> createState() => _GamePage();
}

class _GamePage extends State<GamePage> {
  late final MatchController matchController;

  bool showNumberPage = false;

  void togglePageToShow() {
    setState(() {
      showNumberPage = !showNumberPage;
    });
  }

  @override
  void initState() {
    super.initState();
    matchController = getIt<MatchController>();
  }

  @override
  Widget build(BuildContext context) {
    final myColor = Color(matchController.getMyColor());

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
                              number:  matchController.getSecretNumber() ?? 0,
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
