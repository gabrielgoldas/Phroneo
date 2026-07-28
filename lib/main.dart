import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phroneo/features/auth/presentation/controllers/auth_controller.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';
import 'package:phroneo/l10n/app_localizations.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  // Prepare Flutter before using plugins
  WidgetsFlutterBinding.ensureInitialized();

  // Connecting app to Firebase project
  await Firebase.initializeApp(
    // Use the correct config
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencies();

  runApp(PhroneoApp());
}

class PhroneoApp extends StatelessWidget {
  PhroneoApp({super.key});

  final authController = getIt<AuthController>();
  final matchController = getIt<MatchController>();
  late final router = createRouter(authController, matchController);

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