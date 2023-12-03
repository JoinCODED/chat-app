import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided for that user.');
      } else {
        throw AuthException(e.message!);
      }
    }
  }

  Future<User?> upgradeAnonymousUser(
      String name, String email, String password) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw AuthException("Couldn't upgrade anonymous user");
    }
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.linkWithCredential(credential);
      await user.updateDisplayName(name);
      return user;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future<User?> upgradeAnonymousUserWithGoogle() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw AuthException("Couldn't upgrade anonymous user");
    }
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final providers =
          await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
      if (providers.isEmpty) {
        await user.linkWithCredential(credential);
        return user;
      } else {
        return _firebaseAuth
            .signInWithCredential(credential)
            .then((value) => value.user);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw AuthException(e.toString());
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final providers =
          await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
      if (providers.isEmpty) {
        await GoogleSignIn().signOut();
        throw AuthException(
            'لا يوجد حساب مرتبط بهذا البريد الإلكتروني يرجى إنشاء حساب جديد');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
