import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/motorcycles/motorcycles_template.dart';

class MotorcyclesScreen extends ConsumerStatefulWidget {
  const MotorcyclesScreen({super.key});

  @override
  ConsumerState<MotorcyclesScreen> createState() => _MotorcyclesScreenState();
}

class _MotorcyclesScreenState extends ConsumerState<MotorcyclesScreen> {
  final bool _isLoading = false;
  final String? _errorMessage = null;
  final _motorcycles = const <MotorcycleData>[
    MotorcycleData(
      brand: 'Honda',
      model: 'CB650R',
      plateNumber: 'RK-2024-NEO',
      odometerKm: 12450,
      isActive: true,
    ),
  ];

  void _openMotorcycle(MotorcycleData motorcycle) {}

  void _addMotorcyclePhoto(MotorcycleData motorcycle) {}

  void _addMotorcycle() {
    ref.read(appRouterProvider).go(AppRoutes.addMotorcycle);
  }

  void _retryLoadingMotorcycles() {}

  @override
  Widget build(BuildContext context) {
    return MotorcyclesTemplate(
      motorcycles: _motorcycles,
      isLoading: _isLoading,
      errorMessage: _errorMessage,
      onMotorcyclePressed: _openMotorcycle,
      onAddPhotoPressed: _addMotorcyclePhoto,
      onAddMotorcyclePressed: _addMotorcycle,
      onRetry: _retryLoadingMotorcycles,
    );
  }
}
