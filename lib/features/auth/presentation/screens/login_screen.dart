import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/features/auth/presentation/templates/login/login_template.dart';
import 'package:riders_keeper/features/auth/providers/auth_provider.dart';
import 'package:riders_keeper/features/auth/providers/auth_status.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identityController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateIdentity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your email or username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }
    return null;
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await ref.read(authProvider.notifier).signIn();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider) == AuthStatus.loading;

    return LoginTemplate(
      formKey: _formKey,
      identityController: _identityController,
      passwordController: _passwordController,
      rememberMe: _rememberMe,
      obscurePassword: _obscurePassword,
      isLoading: isLoading,
      identityValidator: _validateIdentity,
      passwordValidator: _validatePassword,
      onRememberMeChanged: (value) => setState(() => _rememberMe = value),
      onPasswordVisibilityChanged: () {
        setState(() => _obscurePassword = !_obscurePassword);
      },
      onLogin: _submit,
      onContinueWithGoogle: _continueWithGoogle,
      onForgotPassword: () {
        ref.read(appRouterProvider).go(AppRoutes.forgotPassword);
      },
      onCreateAccount: () {
        ref.read(appRouterProvider).go(AppRoutes.register);
      },
    );
  }

  void _continueWithGoogle() {
    // TODO: Start Google authentication through AuthRepository.
  }
}
