import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/core/types/service_history_types.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/service_history/service_history_template.dart';

@Preview(name: 'Service History', group: 'Motorcycle', size: Size(390, 844))
Widget serviceHistoryPreview() => MDWidgetPreview(
  child: ServiceHistoryTemplate(
    motorcycle: const MotorcycleData(
      brand: 'Ducati',
      model: 'Panigale V4S',
      plateNumber: 'RD-KPR-01',
      odometerKm: 12450,
      isActive: true,
    ),
    year: '2024',
    vinSuffix: '7842•••09',
    records: const [
      ServiceRecordData(
        title: 'Oil Change',
        date: 'Oct 24, 2024',
        odometerKm: 12450,
        cost: 1450,
        icon: Icons.handyman_rounded,
        status: ServiceRecordStatus.completed,
        year: 2024,
        category: 'Oil Change',
      ),
      ServiceRecordData(
        title: 'Chain Lubrication',
        date: 'Aug 12, 2024',
        odometerKm: 10200,
        cost: 450,
        icon: Icons.handyman_rounded,
        status: ServiceRecordStatus.inspected,
        year: 2024,
        category: 'Chain Service',
      ),
    ],
    totalCost: 1900,
    yearlyBudget: 6000,
    daysSinceLastService: 48,
    lastServiceDate: 'Oct 24, 2024',
    selectedYear: 2024,
    availableYears: const [2024, 2023],
    selectedCategory: 'All services',
    categories: const [
      'All services',
      'Oil Change',
      'Air Filter',
      'Spark Plugs',
      'Coolant Service',
      'Brake Service',
      'Chain Service',
      'Tire Service',
      'Battery Service',
      'General Inspection',
    ],
    onBack: () {},
    onReport: () {},
    onYearChanged: (_) {},
    onCategoryChanged: (_) {},
    onRecordSelected: (_) {},
  ),
);
