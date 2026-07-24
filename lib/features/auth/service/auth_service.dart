import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService {

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthService({
    required FirebaseAuth firebaseAuth,
    required this._googleSignIn,
  }) : _auth = firebaseAuth;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signInWithGoogle() async {

    try {

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();


      // If user cancel login, return null
      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(credential);
      
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) print(e.message);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Google Sign In error: $e');
      rethrow;
    }
    return null;
  }

  Future<void> signOutFromGoogle() async {
    try {
      await _auth.signOut();

      // Checks and logs out of Google
      if (await _googleSignIn.isSignedIn()) {
        // Disconnect revokes the token and forces account selection at the next login.
        await _googleSignIn.disconnect();
      }

    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}