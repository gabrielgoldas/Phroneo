import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phroneo/core/di/injection.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/utils/localization_build_context.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class CreateMatchMenuBottomSheet extends StatefulWidget {
  const CreateMatchMenuBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _CreateMatchMenuBottomSheet();

  static void showCreateMatchMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const CreateMatchMenuBottomSheet(),
    );
  }
}

class _CreateMatchMenuBottomSheet extends State<CreateMatchMenuBottomSheet> {
  late final MatchController matchController;
  int selectedPlayers = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    matchController = getIt<MatchController>();
  }

  void startIncrement() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (selectedPlayers < 20) {
        setState(() => selectedPlayers++);
      }
    });
  }

  void startDecrement() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (selectedPlayers > 3) {
        setState(() => selectedPlayers--);
      }
    });
  }

  void stop() => _timer?.cancel();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return matchController.isLoading
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.00),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              strings.create_match,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppFontSize.titleMedium,
                fontFamily: AppFonts.cinzel,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              strings.player_count_question,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppFontSize.titleSmall,
                fontFamily: AppFonts.cormorantInfant,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onLongPressStart: (_) => startDecrement(),
                  onLongPressEnd: (_) => stop(),
                  child: IconButton(
                    onPressed: selectedPlayers > 3
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
                  onLongPressEnd: (_) => stop(),
                  child: IconButton(
                    onPressed: selectedPlayers < 20
                        ? () => setState(() => selectedPlayers++)
                        : null,
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            CustomElevatedButton(
                text: strings.confirm_creation,
                onPressed: () {
                  matchController.createMatch(context, selectedPlayers);
                }
            ),
          ],
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
