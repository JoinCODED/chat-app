

import 'package:chater/app/modules/auth/domain/providers/auth_providers.dart';
import 'package:chater/app/modules/auth/domain/providers/state/auth_state.dart';
import 'package:chater/app/modules/auth/domain/repo/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(super.state, this._authRepository);
  final AuthRepository _authRepository;

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
