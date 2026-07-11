import 'package:flutter/material.dart';
import 'package:phroneo/l10n/app_localizations.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(const PhroneoApp());
}

class PhroneoApp extends StatelessWidget {
  const PhroneoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // Global theme configuration
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          primary: AppColors.primaryColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.black
          ),
        ),
      ),
    );
  }
}