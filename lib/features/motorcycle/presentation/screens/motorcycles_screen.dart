import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_input_box/md_input_box.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
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
  final _odometerController = TextEditingController();
  var _motorcycles = const <MotorcycleData>[
    MotorcycleData(
      brand: 'Honda',
      model: 'CB650R',
      plateNumber: 'RK-2024-NEO',
      odometerKm: 12450,
      isActive: true,
    ),
  ];
  final _updatedOdometers = <String>{};

  @override
  void dispose() {
    _odometerController.dispose();
    super.dispose();
  }

  void _openMotorcycle(MotorcycleData motorcycle) {
    ref.read(appRouterProvider).go(AppRoutes.vehicleDetails, extra: motorcycle);
  }

  void _addMotorcyclePhoto(MotorcycleData motorcycle) {}

  void _addMotorcycle() {
    ref.read(appRouterProvider).go(AppRoutes.addMotorcycle);
  }

  Future<void> _updateOdometer(MotorcycleData motorcycle) async {
    final formKey = GlobalKey<FormState>();
    _odometerController.text = motorcycle.odometerKm.toString();
    _odometerController.selection = TextSelection.collapsed(
      offset: _odometerController.text.length,
    );
    final newReading = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          14,
          24,
          MediaQuery.viewInsetsOf(sheetContext).bottom + 24,
        ),
        child: SafeArea(
          top: false,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const MDText(
                  'Update odometer',
                  variant: MDTextVariant.title,
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(height: 4),
                MDText(
                  '${motorcycle.brand} ${motorcycle.model} currently has '
                  '${motorcycle.odometerKm} km recorded.',
                  variant: MDTextVariant.bodySmall,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 18),
                MDInputBox(
                  label: 'CURRENT ODOMETER (KM)',
                  controller: _odometerController,
                  prefixIcon: Icons.speed_outlined,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    final reading = int.tryParse(value?.trim() ?? '');
                    if (reading == null || reading < motorcycle.odometerKm) {
                      return 'Enter ${motorcycle.odometerKm} km or higher';
                    }
                    return null;
                  },
                  onSubmitted: (_) {
                    if (formKey.currentState?.validate() ?? false) {
                      Navigator.of(
                        sheetContext,
                      ).pop(int.parse(_odometerController.text.trim()));
                    }
                  },
                ),
                const SizedBox(height: 22),
                MDButton(
                  label: 'SAVE READING',
                  icon: Icons.check_rounded,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      Navigator.of(
                        sheetContext,
                      ).pop(int.parse(_odometerController.text.trim()));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (newReading == null || !mounted) return;

    setState(() {
      _motorcycles = _motorcycles
          .map(
            (item) => item.plateNumber == motorcycle.plateNumber
                ? MotorcycleData(
                    brand: item.brand,
                    model: item.model,
                    plateNumber: item.plateNumber,
                    odometerKm: newReading,
                    imageAsset: item.imageAsset,
                    isActive: item.isActive,
                  )
                : item,
          )
          .toList(growable: false);
      _updatedOdometers.add(motorcycle.plateNumber);
    });
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
      odometerReminderPlateNumbers: _motorcycles
          .where(
            (motorcycle) => !_updatedOdometers.contains(motorcycle.plateNumber),
          )
          .map((motorcycle) => motorcycle.plateNumber)
          .toSet(),
      onUpdateOdometerPressed: _updateOdometer,
      onRetry: _retryLoadingMotorcycles,
    );
  }
}
