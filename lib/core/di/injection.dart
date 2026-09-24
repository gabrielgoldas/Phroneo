import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phroneo/presentation/controllers/auth_controller.dart';
import 'package:phroneo/domain/usecase/auth_use_case.dart';
import 'package:phroneo/presentation/controllers/match_controller.dart';
import 'package:phroneo/data/repository/phrase_repository_impl.dart';
import 'package:phroneo/data/onboarding/onboarding_data.dart';

import '../../data/repository/player_repository_impl.dart';
import '../../data/repository/match_repository_impl.dart';
import '../../domain/repository/match_repository.dart';
import '../../domain/repository/phrase_repository.dart';
import '../../domain/repository/player_repository.dart';
import '../../domain/usecase/match_use_case.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {

  // Registers external packages first
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<OnboardingData>(() => OnboardingData());
  getIt.registerLazySingleton<PhraseRepository>(() => PhraseRepositoryImpl());

  getIt.registerLazySingleton<PlayerRepository>(
          () => PlayerRepositoryImpl( firestore: getIt<FirebaseFirestore>() )
  );

  getIt.registerLazySingleton<MatchRepository>(
          () => MatchRepositoryImpl( firestore: getIt<FirebaseFirestore>() )
  );

  getIt.registerLazySingleton<AuthUseCase>(
      () => AuthUseCase(
          firebaseAuth: getIt<FirebaseAuth>(),
          googleSignIn: getIt<GoogleSignIn>(),
          playerRepository: getIt<PlayerRepository>()
      )
  );

  getIt.registerLazySingleton<AuthController>(
      () => AuthController(authService: getIt<AuthUseCase>())
  );

  getIt.registerLazySingleton<MatchUseCase>(
          () => MatchUseCase(
              authService: getIt<AuthUseCase>(),
              matchRepository: getIt<MatchRepository>(),
              phraseRepository: getIt<PhraseRepository>(),
              playerRepository: getIt<PlayerRepository>(),
      )
  );

  getIt.registerLazySingleton<MatchController>(
          () => MatchController(
              matchService: getIt<MatchUseCase>(),
              authService: getIt<AuthUseCase>()
          )
  );
}