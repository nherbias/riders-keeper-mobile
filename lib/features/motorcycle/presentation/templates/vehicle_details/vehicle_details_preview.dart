import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/vehicle_details/vehicle_details_template.dart';

@Preview(name: 'Vehicle Details', group: 'Motorcycle', size: Size(390, 844))
Widget vehicleDetailsPreview() => MDWidgetPreview(
  child: VehicleDetailsTemplate(
    motorcycle: const MotorcycleData(
      brand: 'Ducati',
      model: 'Panigale V4',
      plateNumber: 'RD-KPR-01',
      odometerKm: 1250,
      isActive: true,
    ),
    nickname: 'The Red Beast',
    year: '2024',
    nextServiceKm: 2500,
    upcomingMaintenance: const [
      UpcomingItemData(
        month: 'DEC',
        day: '15',
        motorcycle: 'Engine Oil Change',
        service: '2,500 KM',
      ),
    ],
    onBack: () {},
    onEdit: () {},
    onUpcomingSelected: (_) {},
    onViewServiceHistory: () {},
    onLogMaintenance: () {},
  ),
);
