import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phroneo/features/auth/presentation/controllers/auth_controller.dart';
import 'package:phroneo/features/auth/service/auth_service.dart';
import 'package:phroneo/features/home/presentation/controller/match_controller.dart';

import '../../features/home/repository/phrase_repository.dart';
import '../../features/home/service/match_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {

  // Registers external packages first
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<PhraseRepository>(() => PhraseRepository());

  getIt.registerLazySingleton<AuthService>(
      () => AuthService(
          firebaseAuth: getIt<FirebaseAuth>(),
          googleSignIn: getIt<GoogleSignIn>(),
          firestore: getIt<FirebaseFirestore>()
      )
  );

  getIt.registerLazySingleton<AuthController>(
      () => AuthController(authService: getIt<AuthService>())
  );

  getIt.registerLazySingleton<MatchService>(
          () => MatchService(
              authService: getIt<AuthService>(),
              firestore: getIt<FirebaseFirestore>(),
              phraseRepository: getIt<PhraseRepository>()
      )
  );

  getIt.registerLazySingleton<MatchController>(
          () => MatchController(
              matchService: getIt<MatchService>(),
              authService: getIt<AuthService>()
          )
  );
}