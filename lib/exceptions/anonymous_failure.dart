class LoginAnonymousFailure implements Exception {
  final String message;

  const LoginAnonymousFailure([
    this.message = 'An unknown exception occurred.',
  ]);
}
