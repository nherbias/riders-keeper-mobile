import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';
import 'package:riders_keeper/core/types/motorcycle_draft.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/vehicle_details/vehicle_details_template.dart';

class VehicleDetailsScreen extends ConsumerStatefulWidget {
  const VehicleDetailsScreen({required this.motorcycle, super.key});

  final MotorcycleData motorcycle;

  @override
  ConsumerState<VehicleDetailsScreen> createState() =>
      _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends ConsumerState<VehicleDetailsScreen> {
  final _upcomingMaintenance = const <UpcomingItemData>[
    UpcomingItemData(
      month: 'DEC',
      day: '15',
      motorcycle: 'Engine Oil Change',
      service: '2,500 KM',
    ),
    UpcomingItemData(
      month: 'JAN',
      day: '20',
      motorcycle: 'Brake Fluid Flush',
      service: '5,000 KM',
    ),
  ];

  void _goBack() {
    ref.read(appRouterProvider).go(AppRoutes.garage);
  }

  void _editVehicle() {
    final motorcycle = widget.motorcycle;
    ref
        .read(appRouterProvider)
        .go(
          AppRoutes.addMotorcycle,
          extra: MotorcycleDraft(
            brand: motorcycle.brand,
            model: motorcycle.model,
            year: '2024',
            plateNumber: motorcycle.plateNumber,
            odometerKm: motorcycle.odometerKm,
            nickname: motorcycle.model,
          ),
        );
  }

  void _openUpcomingMaintenance(UpcomingItemData _) {
    ref.read(appRouterProvider).go(AppRoutes.calendar);
  }

  void _viewServiceHistory() {
    ref
        .read(appRouterProvider)
        .go(AppRoutes.serviceHistory, extra: widget.motorcycle);
  }

  void _logMaintenance() {
    ref
        .read(appRouterProvider)
        .go(AppRoutes.logMaintenance, extra: widget.motorcycle);
  }

  @override
  Widget build(BuildContext context) {
    return VehicleDetailsTemplate(
      motorcycle: widget.motorcycle,
      nickname: widget.motorcycle.model,
      year: '2024',
      nextServiceKm: 2500,
      upcomingMaintenance: _upcomingMaintenance,
      onBack: _goBack,
      onEdit: _editVehicle,
      onUpcomingSelected: _openUpcomingMaintenance,
      onViewServiceHistory: _viewServiceHistory,
      onLogMaintenance: _logMaintenance,
    );
  }
}
