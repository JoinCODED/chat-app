class AuthState {
  final bool isAuth;
  final bool isLoading;
  final String? error;
  final String? userName;
  final String? email;
  final String? password;

  AuthState({
    this.isAuth = false,
    this.isLoading = false,
    this.error,
    this.userName,
    this.email,
    this.password,
  });

  AuthState copyWith({
    bool? isAuth,
    bool? isLoading,
    String? error,
    String? userName,
    String? email,
    String? password,
  }) {
    return AuthState(
      isAuth: isAuth ?? this.isAuth,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
