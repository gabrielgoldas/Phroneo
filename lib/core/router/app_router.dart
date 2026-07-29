import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/features/auth/presentation/controllers/auth_controller.dart';
import 'package:phroneo/features/game/presentation/pages/game_page.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';
import 'package:phroneo/features/home/presentation/pages/home_page.dart';
import 'package:phroneo/features/home/presentation/widgets/qr_scanner_screen.dart';
import 'package:phroneo/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:phroneo/features/auth/presentation/pages/login_page.dart';
import 'package:phroneo/features/ordering/presentation/pages/ordering_page.dart';
import 'package:phroneo/features/ordering/presentation/widgets/round_result_page.dart';
import 'package:phroneo/features/room_lobby/presentation/pages/room_lobby_page.dart';

import '../constants/constants.dart';

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
        builder: (context, state) => const Onboarding(),
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