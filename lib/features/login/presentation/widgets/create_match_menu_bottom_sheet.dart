import 'dart:async';

import 'package:flutter/material.dart';

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
  int selectedPlayers = 2;
  Timer? _timer;

  void startIncrement() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (selectedPlayers < 20) {
        setState(() => selectedPlayers++);
      }
    });
  }

  void startDecrement() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (selectedPlayers > 2) {
        setState(() => selectedPlayers--);
      }
    });
  }

  void stop() => _timer?.cancel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.00),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.create_match,
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
              context.l10n.player_count_question,
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
                text: context.l10n.confirm_creation,
                onPressed: () {}
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
