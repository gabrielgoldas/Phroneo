import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phroneo/features/auth/presentation/controller/auth_controller.dart';
import 'package:phroneo/features/auth/service/auth_service.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';
import 'package:phroneo/features/home/repository/phrase_repository.dart';
import 'package:phroneo/features/onboarding/repository/onboarding_repository.dart';

import '../../features/auth/repository/player_repository.dart';
import '../../features/home/repository/match_repository.dart';
import '../../features/home/service/match_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {

  // Registers external packages first
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<OnboardingRepository>(() => OnboardingRepository());
  getIt.registerLazySingleton<PhraseRepository>(() => PhraseRepository());

  getIt.registerLazySingleton<PlayerRepository>(
          () => PlayerRepository( firestore: getIt<FirebaseFirestore>() )
  );

  getIt.registerLazySingleton<MatchRepository>(
          () => MatchRepository( firestore: getIt<FirebaseFirestore>() )
  );

  getIt.registerLazySingleton<AuthService>(
      () => AuthService(
          firebaseAuth: getIt<FirebaseAuth>(),
          googleSignIn: getIt<GoogleSignIn>(),
          playerRepository: getIt<PlayerRepository>()
      )
  );

  getIt.registerLazySingleton<AuthController>(
      () => AuthController(authService: getIt<AuthService>())
  );

  getIt.registerLazySingleton<MatchService>(
          () => MatchService(
              authService: getIt<AuthService>(),
              matchRepository: getIt<MatchRepository>(),
              phraseRepository: getIt<PhraseRepository>(),
              playerRepository: getIt<PlayerRepository>(),
      )
  );

  getIt.registerLazySingleton<MatchController>(
          () => MatchController(
              matchService: getIt<MatchService>(),
              authService: getIt<AuthService>()
          )
  );
}