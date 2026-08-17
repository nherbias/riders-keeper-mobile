import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/core/types/service_history_types.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/service_history/service_history_template.dart';

class ServiceHistoryScreen extends ConsumerStatefulWidget {
  const ServiceHistoryScreen({required this.motorcycle, super.key});

  final MotorcycleData motorcycle;

  @override
  ConsumerState<ServiceHistoryScreen> createState() =>
      _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends ConsumerState<ServiceHistoryScreen> {
  static const _allCategories = 'All services';
  int _selectedYear = 2024;
  String _selectedCategory = _allCategories;

  final _records = const <ServiceRecordData>[
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
    ServiceRecordData(
      title: 'Brake Pad Service',
      date: 'May 20, 2024',
      odometerKm: 8500,
      cost: 2100,
      icon: Icons.handyman_rounded,
      status: ServiceRecordStatus.recommended,
      year: 2024,
      category: 'Brake Service',
    ),
  ];

  List<ServiceRecordData> get _visibleRecords => _records
      .where((record) {
        final matchesYear = record.year == _selectedYear;
        final matchesCategory =
            _selectedCategory == _allCategories ||
            record.category == _selectedCategory;
        return matchesYear && matchesCategory;
      })
      .toList(growable: false);

  void _goBack() {
    ref
        .read(appRouterProvider)
        .go(AppRoutes.vehicleDetails, extra: widget.motorcycle);
  }

  void _showReport() {}

  void _selectYear(int year) => setState(() => _selectedYear = year);

  void _selectCategory(String category) =>
      setState(() => _selectedCategory = category);

  void _openRecord(ServiceRecordData _) {}

  @override
  Widget build(BuildContext context) {
    final visibleRecords = _visibleRecords;
    final totalCost = visibleRecords.fold<double>(
      0,
      (total, record) => total + record.cost,
    );

    return ServiceHistoryTemplate(
      motorcycle: widget.motorcycle,
      year: '2024',
      vinSuffix: '7842•••09',
      records: visibleRecords,
      totalCost: totalCost,
      yearlyBudget: 6000,
      daysSinceLastService: 48,
      lastServiceDate: 'Oct 24, 2024',
      selectedYear: _selectedYear,
      availableYears: const [2024, 2023, 2022],
      selectedCategory: _selectedCategory,
      categories: const [
        _allCategories,
        'Oil Change',
        'Air Filter',
        'Spark Plugs',
        'Valve Inspection',
        'Coolant Service',
        'Brake Service',
        'Brake Fluid',
        'Chain Service',
        'Tire Service',
        'Battery Service',
        'Suspension Service',
        'Clutch Service',
        'Transmission Service',
        'General Inspection',
      ],
      onBack: _goBack,
      onReport: _showReport,
      onYearChanged: _selectYear,
      onCategoryChanged: _selectCategory,
      onRecordSelected: _openRecord,
    );
  }
}
