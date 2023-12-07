import 'package:chater/app/modules/auth/domain/providers/controller/auth_controller.dart';
import 'package:chater/app/modules/auth/domain/providers/state/auth_state.dart';
import 'package:chater/app/modules/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  ref.read(authControllerProvider);
  return authRepository.authStateChanges;
});

final authControllerProvider = StateNotifierProvider((ref) => AuthController(
      AuthState(),
      ref.watch(authRepositoryProvider),
    ));

final checkIfAuthinticated =
    FutureProvider((ref) => ref.watch(authStateProvider));
