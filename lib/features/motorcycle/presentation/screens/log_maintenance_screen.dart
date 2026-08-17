import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/core/types/service_history_types.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/log_maintenance/log_maintenance_template.dart';

class LogMaintenanceScreen extends ConsumerStatefulWidget {
  const LogMaintenanceScreen({required this.motorcycle, super.key});

  final MotorcycleData motorcycle;

  @override
  ConsumerState<LogMaintenanceScreen> createState() =>
      _LogMaintenanceScreenState();
}

class _LogMaintenanceScreenState extends ConsumerState<LogMaintenanceScreen> {
  static const _services = <String>[
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
  ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _dateController;
  late final TextEditingController _odometerController;
  late final TextEditingController _costController;
  late final TextEditingController _notesController;
  String _selectedService = _services.first;
  ServiceRecordStatus _selectedStatus = ServiceRecordStatus.completed;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: _formatDate(_selectedDate));
    _odometerController = TextEditingController(
      text: widget.motorcycle.odometerKm.toString(),
    );
    _costController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _odometerController.dispose();
    _costController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _goBack() {
    ref
        .read(appRouterProvider)
        .go(AppRoutes.vehicleDetails, extra: widget.motorcycle);
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date == null || !mounted) return;
    setState(() {
      _selectedDate = date;
      _dateController.text = _formatDate(date);
    });
  }

  String? _validateOdometer(String? value) {
    final odometer = int.tryParse(value?.trim() ?? '');
    if (odometer == null || odometer < 0) {
      return 'Enter a valid odometer reading';
    }
    return null;
  }

  String? _validateCost(String? value) {
    final cost = double.tryParse(value?.trim() ?? '');
    if (cost == null || cost < 0) return 'Enter a valid service cost';
    return null;
  }

  void _selectService(String service) {
    setState(() => _selectedService = service);
  }

  void _selectStatus(ServiceRecordStatus status) {
    setState(() => _selectedStatus = status);
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Maintenance record saved.')));
    ref
        .read(appRouterProvider)
        .go(AppRoutes.serviceHistory, extra: widget.motorcycle);
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return LogMaintenanceTemplate(
      formKey: _formKey,
      motorcycle: widget.motorcycle,
      dateController: _dateController,
      odometerController: _odometerController,
      costController: _costController,
      notesController: _notesController,
      services: _services,
      selectedService: _selectedService,
      selectedStatus: _selectedStatus,
      availableStatuses: const [
        ServiceRecordStatus.completed,
        ServiceRecordStatus.inspected,
      ],
      isLoading: _isLoading,
      odometerValidator: _validateOdometer,
      costValidator: _validateCost,
      onBack: _goBack,
      onSelectDate: _selectDate,
      onServiceChanged: _selectService,
      onStatusChanged: _selectStatus,
      onSubmit: _submit,
    );
  }
}
