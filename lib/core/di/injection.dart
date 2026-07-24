import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phroneo/features/auth/presentation/controllers/auth_controller.dart';
import 'package:phroneo/features/auth/service/auth_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {

  // Registers external packages first
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  getIt.registerLazySingleton<AuthService>(
      () => AuthService(
          firebaseAuth: getIt<FirebaseAuth>(),
          googleSignIn: getIt<GoogleSignIn>()
      )
  );

  getIt.registerLazySingleton<AuthController>(
      () => AuthController(authService: getIt<AuthService>())
  );
}