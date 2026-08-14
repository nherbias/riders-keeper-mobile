import 'package:go_router/go_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/features/calendar/presentation/screens/calendar_screen.dart';

final calendarRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.calendar,
    name: AppRouteNames.calendar,
    builder: (context, state) => const CalendarScreen(),
  ),
];
