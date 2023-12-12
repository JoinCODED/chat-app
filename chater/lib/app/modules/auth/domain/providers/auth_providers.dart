import 'package:chater/app/modules/auth/domain/providers/controller/auth_controller.dart';
import 'package:chater/app/modules/auth/domain/providers/controller/form_controller.dart';
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

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(
      AuthState(),
      ref.watch(authRepositoryProvider),
    );
  },
);

final authFormController =
    ChangeNotifierProvider((ref) => MyAuthFormController());

final checkIfAuthinticated =
    FutureProvider((ref) => ref.watch(authStateProvider));
