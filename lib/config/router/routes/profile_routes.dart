import 'package:go_router/go_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/features/profile/presentation/screens/profile_screen.dart';

final profileRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.profile,
    name: AppRouteNames.profile,
    builder: (context, state) => const ProfileScreen(),
  ),
];
