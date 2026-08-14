import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';
import 'package:riders_keeper/features/home/presentation/templates/predictions/predictions_template.dart';

class PredictionsScreen extends ConsumerStatefulWidget {
  const PredictionsScreen({super.key});

  @override
  ConsumerState<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends ConsumerState<PredictionsScreen> {
  final _items = const <PredictionItemData>[
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
    PredictionItemData(
      motorcycle: 'Yamaha Mio',
      detail: 'Brake Inspection: ~320 km remaining',
      progress: .64,
    ),
    PredictionItemData(
      motorcycle: 'Ducati Panigale V4',
      detail: 'Coolant Service: ~35 days',
      progress: .82,
    ),
  ];

  void _openPrediction(PredictionItemData item) {
    // TODO: Navigate to prediction details when its route is available.
  }

  @override
  Widget build(BuildContext context) {
    return PredictionsTemplate(
      items: _items,
      onBack: () => ref.read(appRouterProvider).go(AppRoutes.home),
      onItemSelected: _openPrediction,
    );
  }
}
