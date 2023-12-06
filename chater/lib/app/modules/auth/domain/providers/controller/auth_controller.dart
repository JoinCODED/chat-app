import 'package:chater/app/modules/auth/domain/providers/auth_providers.dart';
import 'package:chater/app/modules/auth/domain/providers/state/auth_state.dart';
import 'package:chater/app/modules/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(super.state, this._authRepository);
  final AuthRepository _authRepository;

  // Our Function will take email,password, username and buildcontext
  void register(
    String email,
    String password,
    String username,
  ) async {
    try {
      // Get back usercredential future from createUserWithEmailAndPassword method
      User? userCred = await _authRepository.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCred != null) {
        // Save username name
        await userCred.updateDisplayName(username);

        // After that access "users" Firestore in firestore and save username, email and userLocation
        // final updateUserResult =
        //     await authApi.setUserInformation(userCred, username, email);

        // if (updateUserResult) {
        state = state.copyWith(isLoading: false, isAuth: true);
        // }
      }
    } on FirebaseAuthException catch (e) {
      // In case of error
      // if email already exists
      if (e.code == "email-already-in-use") {
        state = state.copyWith(
            isLoading: false,
            isAuth: false,
            error: "The account with this email already exists.");
        debugPrint("The account with this email already exists.");
      }
      if (e.code == 'weak-password') {
        // If password is too weak
        state = state.copyWith(
            isLoading: false, isAuth: false, error: "Password is too weak.");
        debugPrint("Password is too weak.");
      }
    } catch (e) {
      // For anything else
      state =
          state.copyWith(isLoading: false, isAuth: false, error: e.toString());
      debugPrint("Something went wrong please try again.");
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user =
          await _authRepository.signInWithEmailAndPassword(email, password);
      if (user != null) {
        state = state.copyWith(isLoading: false, isAuth: true);
      }
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        state = state.copyWith(
          isLoading: false,
          isAuth: true,
        );
      } else {
        state = state.copyWith(
            isLoading: false, error: "Cannot retrieve user data");
      }
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message.toString());
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = state.copyWith(
      isAuth: false,
      error: null,
    );
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(
      AuthState(),
      ref.watch(authRepositoryProvider),
    );
  },
);
