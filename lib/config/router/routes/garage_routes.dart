import 'package:go_router/go_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/features/home/presentation/screens/home_screen.dart';

final homeRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.home,
    name: AppRouteNames.home,
    builder: (context, state) => const HomeScreen(),
  ),
];
