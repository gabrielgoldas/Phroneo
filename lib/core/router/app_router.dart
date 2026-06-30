import 'package:go_router/go_router.dart';
import 'package:phroneo/core/router/app_routes.dart';
import 'package:phroneo/features/game/presentation/pages/game_page.dart';
import 'package:phroneo/features/home/presentation/pages/home_page.dart';
import 'package:phroneo/features/how_to_play/presentation/pages/how_to_play_page.dart';
import 'package:phroneo/features/login/presentation/pages/login_page.dart';
import 'package:phroneo/features/ordering/presentation/pages/ordering_page.dart';
import 'package:phroneo/features/room_lobby/presentation/pages/room_lobby_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: AppRoutes.login,
      path: '/',
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          name: AppRoutes.onboarding,
          path: 'onboarding',
          builder: (context, state) => const HowToPlayPage(),
        ),
        GoRoute(
          name: AppRoutes.home,
          path: 'home',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              name: AppRoutes.roomLobby,
              path: 'room-lobby',
              builder: (context, state) => const RoomLobbyPage(),
              routes: [
                GoRoute(
                  name: AppRoutes.game,
                  path: 'game',
                  builder: (context, state) => const GamePage(),
                  routes: [
                    GoRoute(
                      name: AppRoutes.ordering,
                      path: 'ordering',
                      builder: (context, state) => const OrderingPage(),
                    ),
                  ]
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);