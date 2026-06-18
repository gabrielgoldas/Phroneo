import 'package:go_router/go_router.dart';
import 'package:phroneo/features/game/presentation/pages/home_page.dart';
import 'package:phroneo/features/how_to_play/presentation/pages/how_to_play_page.dart';

final router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
      ),
      GoRoute(
          path: '/onboarding',
        builder: (context, state) => const HowToPlayPage()
      ),
    ]
);