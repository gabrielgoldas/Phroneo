import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/utils/localization_build_context.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';
import 'package:phroneo/features/ordering/model/option.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';

class OrderingPage extends StatefulWidget {
  final MatchController matchController;

  const OrderingPage({ super.key, required this.matchController });

  @override
  State<StatefulWidget> createState() => _OrderingPage();
}

class _OrderingPage extends State<OrderingPage> {
  bool showNumbers = false;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return ListenableBuilder(
      listenable: widget.matchController,
      builder: (context, child) {
        List<Option> options = widget.matchController.getOptions();

        return Scaffold(
          appBar: CustomAppBar(),
          backgroundColor: AppColors.background,
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  strings.sortChoicesInstruction,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.cinzel,
                    fontSize: AppFontSize.bodyLarge,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),

                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        strings.highestNumberLabel,
                        style: TextStyle(
                          fontFamily: AppFonts.cinzel,
                          fontSize: AppFontSize.bodySmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray500,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: options.length,
                        onReorder: widget.matchController.onReorder,
                        proxyDecorator:
                          ( Widget child, int index, Animation<double> animation ) {
                            return AnimatedBuilder(
                              animation: animation,
                              builder: (BuildContext context, Widget? child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: child,
                                );
                              },
                              child: child,
                            );
                          },

                        itemBuilder: (context, index) {
                          final option = options[index];

                          return Container(
                            key: ValueKey(
                              '${option.number}_${option.color.value}',
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            width: double.infinity,
                            height: 60.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: option.color,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              showNumbers ? option.number.toString() : '',
                              style: TextStyle(
                                fontFamily: AppFonts.cinzel,
                                color: AppColors.gray200,
                                fontSize: AppFontSize.bodyLargeX,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        strings.lowestNumberLabel,
                        style: TextStyle(
                          fontFamily: AppFonts.cinzel,
                          fontSize: AppFontSize.bodySmall,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray500,
                        ),
                      ),
                    ),
                  ],
                ),

                if (widget.matchController.isHost)
                  CustomElevatedButton(
                    text: strings.doneButton,
                    onPressed: () async {
                      setState(() => showNumbers = true);
                      await widget.matchController.finishRoundAndSaveResult();
                      await Future.delayed(const Duration(seconds: 2));
                      if (context.mounted) context.goNamed(AppRoutes.roundResult);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}