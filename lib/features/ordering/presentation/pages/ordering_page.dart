import 'package:flutter/material.dart';
import 'package:phroneo/core/theme/app_colors.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';

import '../../../../core/theme/app_font_size.dart';
import '../../../../core/theme/app_fonts.dart';

class OrderingPage extends StatefulWidget {
  const OrderingPage({ super.key });

  @override
  State<StatefulWidget> createState() => _OrderingPage();
}

class _OrderingPage extends State<OrderingPage> {
  final _options = <Option>[
    Option(number: 72, color: AppColors.orange),
    Option(number: 50, color: AppColors.gray300),
    Option(number: 22, color: AppColors.green),
    Option(number: 87, color: AppColors.grayBlue),
    Option(number: 10, color: AppColors.yellow),
  ];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final Option item = _options.removeAt(oldIndex);
      _options.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            const Text(
              'Coloque as cores do maior para o menor',
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Maior número (100)',
                    style: TextStyle(
                      fontFamily: AppFonts.cinzel,
                      fontSize: AppFontSize.bodySmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray500,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 24.0),
                  child: ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _options.length,
                    onReorderItem: _onReorder,
                    proxyDecorator: (Widget child, int index, Animation<double> animation) {
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
                                  )
                                ]
                              ),
                              child: child,
                            );
                          },
                        child: child,
                      );
                    },

                    itemBuilder: (context, index) {
                      final option = _options[index];

                      return Container(
                        key: ValueKey(option.number),
                        margin: const EdgeInsetsGeometry.symmetric(vertical: 8),
                        width: double.infinity,
                        height: 60.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: option.color,
                            borderRadius: BorderRadius.circular(12.0)
                        ),
                        child: Text(
                          option.number.toString(),
                        ),
                      );
                    },
                  ),
                ),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Menor número (1)',
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

            CustomElevatedButton(
                text: "Concluído",
                onPressed: () {
                  final List<int> finalOpt = _options.map((option) => option.number).toList();
                  final String stringFormatted = finalOpt.join(', ');

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ordem atual: $stringFormatted'),
                      duration: const Duration(seconds: 4),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }
            )

          ],
        ),
      ),
    );
  }
}

class Option {
  final int number;
  final Color color;

  const Option({
    required this.number,
    required this.color,
  });
}