import 'package:go_router/go_router.dart';
import 'package:phroneo/features/home/presentation/pages/home_page.dart';
import 'package:phroneo/features/how_to_play/presentation/pages/how_to_play_page.dart';
import 'package:phroneo/features/login/presentation/pages/login_page.dart';
import 'package:phroneo/features/room_lobby/presentation/pages/room_lobby_page.dart';

final router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
          path: '/onboarding',
        builder: (context, state) => const HowToPlayPage()
      ),
      GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage()
      ),
      GoRoute(
        path: '/room_lobby',
        builder: (context, state) => const RoomLobbyPage()
      )
    ]
);