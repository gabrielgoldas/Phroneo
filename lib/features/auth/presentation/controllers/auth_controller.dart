import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phroneo/features/auth/service/auth_service.dart';

import '../../../../core/router/app_routes.dart';
import '../../../components/show_message.dart';

class AuthController extends ChangeNotifier {

  final AuthService _authService;

  bool isLoading = false;
  User? user;

  late StreamSubscription<User?> _subscription;


  AuthController({required this._authService}) {
    _authService.authStateChanges.listen((firebaseUser) {
      user = firebaseUser;
      notifyListeners();
    });
  }

  bool get isLoggedIn => user != null;

  Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final isNewUser = await _authService.signInWithGoogle();
      (isNewUser != null && isNewUser) ? context.pushNamed(AppRoutes.onboarding) : context.pushNamed(AppRoutes.home);

    } on FirebaseAuthException catch(e) {
      ShowMessage(title: 'Error', message: e.message!,);
    } catch (e) {

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao fazer login com o Google')),
      );

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    try {
      await _authService.signOutFromGoogle();
    } catch(e){
      if(e is FirebaseAuthException){
        ShowMessage(title: 'Error', message: e.message!,);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}