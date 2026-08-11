import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:riders_keeper/features/auth/presentation/screens/login_screen.dart';
import 'package:riders_keeper/features/auth/presentation/screens/signup_screen.dart';

final authRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.root,
    name: AppRouteNames.root,
    builder: (context, state) => const Scaffold(body: SizedBox.expand()),
  ),
  GoRoute(
    path: AppRoutes.login,
    name: AppRouteNames.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: AppRoutes.register,
    name: AppRouteNames.register,
    builder: (context, state) => const SignupScreen(),
  ),
  GoRoute(
    path: AppRoutes.forgotPassword,
    name: AppRouteNames.forgotPassword,
    builder: (context, state) => const ForgotPasswordScreen(),
  ),
];
