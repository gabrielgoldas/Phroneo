
import 'package:get_it/get_it.dart';
import 'package:phroneo/features/auth/presentation/controllers/auth_controller.dart';
import 'package:phroneo/features/auth/service/auth_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<AuthService>(
      () => AuthService()
  );

  getIt.registerLazySingleton<AuthController>(
      () => AuthController(authService: getIt<AuthService>())
  );
}