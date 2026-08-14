import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/features/home/presentation/templates/home/home_template.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final int _currentNavigationIndex = 0;
  final _summary = const GarageSummaryData(
    health: 87,
    total: 5,
    healthy: 3,
    overdue: 1,
  );
  final _attentionItems = const <AttentionItemData>[
    AttentionItemData(
      motorcycle: 'Yamaha Mio',
      detail: 'Brake Inspection',
      status: 'CRITICAL',
      isCritical: true,
      urgencyLabel: '3 DAYS LATE',
    ),
    AttentionItemData(
      motorcycle: 'Honda Click 125',
      detail: 'Oil Change',
      status: 'ATTENTION',
      isCritical: false,
      urgencyLabel: '2 DAYS LEFT',
    ),
  ];
  final _predictionItems = const <PredictionItemData>[
    PredictionItemData(
      motorcycle: 'Honda Click 125',
      detail: 'Oil Change: ~450 km remaining',
      progress: .75,
    ),
    PredictionItemData(
      motorcycle: 'Honda PCX',
      detail: 'Tire Replacement: ~20 days',
      progress: .90,
    ),
  ];
  final _upcomingItems = const <UpcomingItemData>[
    UpcomingItemData(
      month: 'JUL',
      day: '30',
      motorcycle: 'Honda Click 125',
      service: 'OIL CHANGE',
    ),
    UpcomingItemData(
      month: 'AUG',
      day: '02',
      motorcycle: 'Yamaha Mio',
      service: 'BRAKE INSPECTION',
    ),
  ];

  void _selectNavigation(int index) {
    if (index == _currentNavigationIndex) return;

    final location = switch (index) {
      0 => AppRoutes.home,
      1 => AppRoutes.garage,
      2 => AppRoutes.calendar,
      3 => AppRoutes.profile,
      _ => AppRoutes.home,
    };

    ref.read(appRouterProvider).go(location);
  }

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      userName: 'Niko',
      garageSummary: _summary,
      attentionItems: _attentionItems,
      predictionItems: _predictionItems,
      upcomingItems: _upcomingItems,
      onViewAttention: () {
        ref.read(appRouterProvider).go(AppRoutes.needsAttention);
      },
      onViewPredictions: () {
        ref.read(appRouterProvider).go(AppRoutes.predictions);
      },
      onViewCalendar: () => _selectNavigation(2),
      onAttentionSelected: (_) {},
      onPredictionSelected: (_) {},
      onUpcomingSelected: (_) {},
    );
  }
}
