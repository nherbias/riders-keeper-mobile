import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/features/auth/providers/auth_status.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthStatus>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    Future.microtask(_initialize);
    return AuthStatus.initial;
  }

  Future<void> _initialize() async {
    state = AuthStatus.loading;

    // TODO: Restore and validate the stored JWT through AuthRepository.
    state = AuthStatus.unauthenticated;
  }

  Future<void> signIn() async {
    state = AuthStatus.loading;

    // TODO: Authenticate through AuthRepository.
    state = AuthStatus.authenticated;
  }

  Future<void> signOut() async {
    state = AuthStatus.loading;

    // TODO: Clear the stored JWT through AuthRepository.
    state = AuthStatus.unauthenticated;
  }
}
