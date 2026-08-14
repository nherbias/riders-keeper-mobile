import 'package:go_router/go_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/features/home/presentation/screens/home_screen.dart';
import 'package:riders_keeper/features/home/presentation/screens/needs_attention_screen.dart';
import 'package:riders_keeper/features/home/presentation/screens/predictions_screen.dart';
import 'package:riders_keeper/features/motorcycle/presentation/screens/motorcycles_screen.dart';
import 'package:riders_keeper/features/motorcycle/presentation/screens/add_motorcycle_screen.dart';

final homeRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.home,
    name: AppRouteNames.home,
    builder: (context, state) => const HomeScreen(),
  ),
];

final garageRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.garage,
    name: AppRouteNames.garage,
    builder: (context, state) => const MotorcyclesScreen(),
  ),
];

final secondaryNavigationRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.needsAttention,
    name: AppRouteNames.needsAttention,
    builder: (context, state) => const NeedsAttentionScreen(),
  ),
  GoRoute(
    path: AppRoutes.predictions,
    name: AppRouteNames.predictions,
    builder: (context, state) => const PredictionsScreen(),
  ),
  GoRoute(
    path: AppRoutes.addMotorcycle,
    name: AppRouteNames.addMotorcycle,
    builder: (context, state) => const AddMotorcycleScreen(),
  ),
];
