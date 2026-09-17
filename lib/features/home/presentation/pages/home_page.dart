import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/widgets/custom_elevated_button.dart';
import 'package:phroneo/core/widgets/custom_app_bar.dart';
import 'package:phroneo/features/home/bloc/match_bloc.dart';
import 'package:phroneo/features/home/bloc/match_state.dart';
import 'package:phroneo/features/home/presentation/widgets/create_match_menu_bottom_sheet.dart';
import 'package:phroneo/i18n/strings.g.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../bloc/match_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MatchBloc, MatchState>(
      listener: (context, state) {

        if (state.joinSuccess) {
          context.goNamed(AppRoutes.roomLobby);
        }

      },
      child: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(
              showAccount: true,
              showBackButton: false,
            ),
            backgroundColor: AppColors.background,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo_phroneo.svg',
                      width: 80,
                    ),

                    const SizedBox(height: 12),

                    CustomTitle(text: t.homePage.welcome_message),

                    const SizedBox(height: 32),

                    CustomElevatedButton(
                      text: t.homePage.create_match,
                      onPressed: () {
                        CreateMatchMenuBottomSheet.showCreateMatchMenuBottomSheet(
                          context,
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    CustomElevatedButton(
                      text: t.homePage.join_match,
                      onPressed: () async {
                        final String? scannedCode = await context
                            .pushNamed<String>(AppRoutes.qrScanner);

                        if (scannedCode != null && context.mounted) {
                          context.read<MatchBloc>().add(
                            JoinMatch(scannedCode),
                          );
                        }
                      },
                    ),
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
