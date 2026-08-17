import 'package:go_router/go_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/features/home/presentation/screens/home_screen.dart';
import 'package:riders_keeper/features/home/presentation/screens/needs_attention_screen.dart';
import 'package:riders_keeper/features/home/presentation/screens/predictions_screen.dart';
import 'package:riders_keeper/features/motorcycle/presentation/screens/motorcycles_screen.dart';
import 'package:riders_keeper/features/motorcycle/presentation/screens/add_motorcycle_screen.dart';
import 'package:riders_keeper/features/motorcycle/presentation/screens/review_motorcycle_screen.dart';
import 'package:riders_keeper/features/motorcycle/presentation/screens/vehicle_details_screen.dart';
import 'package:riders_keeper/features/motorcycle/presentation/screens/service_history_screen.dart';
import 'package:riders_keeper/features/motorcycle/presentation/screens/log_maintenance_screen.dart';
import 'package:riders_keeper/core/types/motorcycle_draft.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';

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
    builder: (context, state) => AddMotorcycleScreen(
      initialDraft: state.extra is MotorcycleDraft
          ? state.extra! as MotorcycleDraft
          : null,
    ),
  ),
  GoRoute(
    path: AppRoutes.reviewMotorcycle,
    name: AppRouteNames.reviewMotorcycle,
    builder: (context, state) => ReviewMotorcycleScreen(
      draft: state.extra is MotorcycleDraft
          ? state.extra! as MotorcycleDraft
          : const MotorcycleDraft.empty(),
    ),
  ),
  GoRoute(
    path: AppRoutes.vehicleDetails,
    name: AppRouteNames.vehicleDetails,
    builder: (context, state) => VehicleDetailsScreen(
      motorcycle: state.extra is MotorcycleData
          ? state.extra! as MotorcycleData
          : const MotorcycleData(
              brand: 'Honda',
              model: 'CB650R',
              plateNumber: 'RK-2024-NEO',
              odometerKm: 12450,
              isActive: true,
            ),
    ),
  ),
  GoRoute(
    path: AppRoutes.serviceHistory,
    name: AppRouteNames.serviceHistory,
    builder: (context, state) => ServiceHistoryScreen(
      motorcycle: state.extra is MotorcycleData
          ? state.extra! as MotorcycleData
          : const MotorcycleData(
              brand: 'Honda',
              model: 'CB650R',
              plateNumber: 'RK-2024-NEO',
              odometerKm: 12450,
              isActive: true,
            ),
    ),
  ),
  GoRoute(
    path: AppRoutes.logMaintenance,
    name: AppRouteNames.logMaintenance,
    builder: (context, state) => LogMaintenanceScreen(
      motorcycle: state.extra is MotorcycleData
          ? state.extra! as MotorcycleData
          : const MotorcycleData(
              brand: 'Honda',
              model: 'CB650R',
              plateNumber: 'RK-2024-NEO',
              odometerKm: 12450,
              isActive: true,
            ),
    ),
  ),
];
