import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_repo.dart';

class AuthRepoImplementation implements AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Register user with email and password
  @override
  Future<String?> registerUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return 'Unexpected error occurred: $e';
    }
  }

  /// Login user with email and password
  @override
  loginUser(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password for this user';
      } else {
        return e.message;
      }
    } catch (_) {
      return "Unexpected error happened";
    }
  }

  /// Login with Google
  @override
  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return "Login cancelled by user.";
      }

      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken == null) {
        return "Google authentication failed. Try again.";
      }

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Google login failed. Try again.";
    } catch (e) {
      return "Unexpected Google login error: $e";
    }
  }
}
