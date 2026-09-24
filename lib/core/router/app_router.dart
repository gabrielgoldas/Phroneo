import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/di/injection.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/presentation/controllers/auth_controller.dart';
import 'package:phroneo/presentation/pages/home/home_page.dart';
import 'package:phroneo/presentation/pages/home/widgets/qr_scanner_screen.dart';
import 'package:phroneo/presentation/pages/onboarding/onboarding_page.dart';
import 'package:phroneo/presentation/pages/auth/login_page.dart';
import 'package:phroneo/data/onboarding/onboarding_data.dart';
import 'package:phroneo/presentation/pages/ordering/ordering_page.dart';
import 'package:phroneo/presentation/pages/result/round_result_page.dart';
import 'package:phroneo/presentation/pages/room_lobby/room_lobby_page.dart';

import '../../data/constants/constants.dart';
import '../../presentation/controllers/match_controller.dart';
import '../../presentation/pages/game/game_page.dart';

GoRouter createRouter(AuthController authController, MatchController matchController) {
  return GoRouter(
    refreshListenable: Listenable.merge([
      authController,
      matchController,
    ]),
    redirect: (context, state)  {

      // Auth
      final logged = authController.isLoggedIn;
      final itsOnLoginPage = state.uri.path == '/';
      if (!logged && !itsOnLoginPage) return '/';
      if (logged && itsOnLoginPage) return '/home';

      // Match
      final match = matchController.currentMatch;
      final itsOnLobbyPage = state.uri.path == '/room-lobby';

      if (match?.status == StatusMatch.playing && itsOnLobbyPage) {
        return '/game';
      }

      return null;
    },

    routes: [
      GoRoute(
        name: AppRoutes.login,
        path: '/',
        builder: (context, state) => LoginPage( authController: authController )
      ),
      GoRoute(
        name: AppRoutes.onboarding,
        path: '/onboarding',
        builder: (context, state) => Onboarding(
          onboardingRepository: getIt<OnboardingData>()
        ),
      ),
      GoRoute(
        name: AppRoutes.home,
        path: '/home',
        builder: (context, state) => HomePage( matchController: matchController )
      ),
      GoRoute(
        name: AppRoutes.roomLobby,
        path: '/room-lobby',
        builder: (context, state) {
          final roomCode = state.extra as String?;
          return RoomLobbyPage(
            roomCode: roomCode,
            matchController: matchController,
          );
        },
      ),
      GoRoute(
        name: AppRoutes.qrScanner,
        path: '/qr-scanner',
        builder: (context, state) => QrScannerScreen()
      ),
      GoRoute(
        name: AppRoutes.game,
        path: '/game',
        builder: (context, state) => GamePage( matchController: matchController )
      ),
      GoRoute(
        name: AppRoutes.ordering,
        path: '/ordering',
        builder: (context, state) => OrderingPage( matchController: matchController)
      ),
      GoRoute(
        name: AppRoutes.roundResult,
        path: '/round-result',
        builder: (context, state) => RoundResultPage( matchController: matchController )
      )
    ],
  );
}