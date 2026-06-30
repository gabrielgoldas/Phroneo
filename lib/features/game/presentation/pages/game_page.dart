import 'package:flutter/material.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/features/game/presentation/widgets/phrase_page.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/number_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePage();
}

class _GamePage extends State<GamePage>{
  bool showNumberPage = false;
  final Color color = AppColors.orange;

  void togglePageToShow() {
    setState(() {
      showNumberPage = !showNumberPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = showNumberPage
        ? HSLColor.fromColor(color).withLightness(0.35).toColor()
        : color;

    const transitionDuration = Duration(milliseconds: 500);

    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.easeInOut,
      color: backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          textColor: AppColors.background,
          showBackButton: false,
          backgroundColor: Colors.transparent, // 3. Passamos transparente para a sua AppBar
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPressStart: (_) => togglePageToShow(),
          onLongPressEnd: (_) => togglePageToShow(),
          child: SizedBox.expand(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 54.0),
                child: AnimatedSwitcher(
                  duration: transitionDuration,
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: showNumberPage
                      ? const NumberPage(key: ValueKey('number_page'))
                      : const PhrasePage(key: ValueKey('phrase_page')),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}