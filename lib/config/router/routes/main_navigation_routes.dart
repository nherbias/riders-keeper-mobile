import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riders_keeper/config/router/routes/garage_routes.dart';
import 'package:riders_keeper/config/router/routes/profile_routes.dart';
import 'package:riders_keeper/config/router/routes/schedule_routes.dart';
import 'package:riders_keeper/core/design_system/organisms/md_home_bottom_navigation/md_home_bottom_navigation.dart';

final mainNavigationRoutes = <RouteBase>[
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) => Scaffold(
      body: navigationShell,
      bottomNavigationBar: MDHomeBottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    ),
    branches: [
      StatefulShellBranch(routes: homeRoutes),
      StatefulShellBranch(routes: garageRoutes),
      StatefulShellBranch(routes: calendarRoutes),
      StatefulShellBranch(routes: profileRoutes),
    ],
  ),
];
