import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riders_keeper/config/router/app_navigation_provider.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/config/router/routes/auth_routes.dart';
import 'package:riders_keeper/config/router/routes/garage_routes.dart';
import 'package:riders_keeper/config/router/routes/maintenance_routes.dart';
import 'package:riders_keeper/config/router/routes/profile_routes.dart';
import 'package:riders_keeper/config/router/routes/schedule_routes.dart';
import 'package:riders_keeper/features/auth/providers/auth_status.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavKey');

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(appNavigationProvider);
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.root,
    refreshListenable: authState,
    redirect: (context, state) {
      final authStatus = authState.value;
      final location = state.matchedLocation;
      final isAuthRoute =
          location == AppRoutes.login ||
          location == AppRoutes.register ||
          location == AppRoutes.forgotPassword;

      if (authStatus == AuthStatus.initial ||
          authStatus == AuthStatus.loading) {
        return null;
      }

      if (authStatus == AuthStatus.unauthenticated) {
        return isAuthRoute ? null : AppRoutes.login;
      }

      if (authStatus == AuthStatus.authenticated &&
          (location == AppRoutes.root || isAuthRoute)) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      ...authRoutes,
      ...homeRoutes,
      ...garageRoutes,
      ...profileRoutes,
      ...calendarRoutes,
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    ),
  );

  ref.onDispose(router.dispose);

  return router;
});
