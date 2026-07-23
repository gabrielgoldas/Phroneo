import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signWithGoogle() async {

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      return userCredential.user?.uid;
      
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Google Sign In error: $e');
      }
      rethrow;
    }
  }
}