import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/core/types/service_history_types.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/log_maintenance/log_maintenance_template.dart';

@Preview(name: 'Log Maintenance', group: 'Motorcycle', size: Size(390, 844))
Widget logMaintenancePreview() {
  final date = TextEditingController(text: 'Oct 24, 2024');
  final odometer = TextEditingController(text: '12450');
  final cost = TextEditingController(text: '1450');
  final notes = TextEditingController();
  return MDWidgetPreview(
    child: LogMaintenanceTemplate(
      formKey: GlobalKey<FormState>(),
      motorcycle: const MotorcycleData(
        brand: 'Ducati',
        model: 'Panigale V4S',
        plateNumber: 'RD-KPR-01',
        odometerKm: 12450,
        isActive: true,
      ),
      dateController: date,
      odometerController: odometer,
      costController: cost,
      notesController: notes,
      services: const [
        'Oil Change',
        'Air Filter',
        'Spark Plugs',
        'Brake Service',
        'Chain Service',
        'Tire Service',
      ],
      selectedService: 'Oil Change',
      selectedStatus: ServiceRecordStatus.completed,
      isLoading: false,
      odometerValidator: (_) => null,
      costValidator: (_) => null,
      onBack: () {},
      onSelectDate: () {},
      onServiceChanged: (_) {},
      onStatusChanged: (_) {},
      onSubmit: () {},
    ),
  );
}
