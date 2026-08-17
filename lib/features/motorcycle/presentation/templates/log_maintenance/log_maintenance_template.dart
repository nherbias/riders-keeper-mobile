import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_input_box/md_input_box.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/core/types/service_history_types.dart';

class LogMaintenanceTemplate extends StatelessWidget {
  const LogMaintenanceTemplate({
    required this.formKey,
    required this.motorcycle,
    required this.dateController,
    required this.odometerController,
    required this.costController,
    required this.notesController,
    required this.services,
    required this.selectedService,
    required this.selectedStatus,
    required this.availableStatuses,
    required this.isLoading,
    required this.odometerValidator,
    required this.costValidator,
    required this.onBack,
    required this.onSelectDate,
    required this.onServiceChanged,
    required this.onStatusChanged,
    required this.onSubmit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final MotorcycleData motorcycle;
  final TextEditingController dateController;
  final TextEditingController odometerController;
  final TextEditingController costController;
  final TextEditingController notesController;
  final List<String> services;
  final String selectedService;
  final ServiceRecordStatus selectedStatus;
  final List<ServiceRecordStatus> availableStatuses;
  final bool isLoading;
  final FormFieldValidator<String> odometerValidator;
  final FormFieldValidator<String> costValidator;
  final VoidCallback onBack;
  final VoidCallback onSelectDate;
  final ValueChanged<String> onServiceChanged;
  final ValueChanged<ServiceRecordStatus> onStatusChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Log Maintenance',
      appBarLeading: IconButton(
        tooltip: 'Back to vehicle details',
        onPressed: isLoading ? null : onBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _VehicleBanner(motorcycle: motorcycle),
                  const SizedBox(height: 20),
                  const MDText(
                    'Service details',
                    variant: MDTextVariant.title,
                    fontWeight: FontWeight.w800,
                  ),
                  const SizedBox(height: 4),
                  const MDText(
                    'Add the completed work to this motorcycle’s history.',
                    variant: MDTextVariant.bodySmall,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 18),
                  _ServicePicker(
                    services: services,
                    selectedService: selectedService,
                    enabled: !isLoading,
                    onSelected: onServiceChanged,
                  ),
                  const SizedBox(height: 16),
                  MDInputBox(
                    label: 'SERVICE DATE',
                    controller: dateController,
                    prefixIcon: Icons.event_outlined,
                    suffixIcon: Icons.calendar_month_rounded,
                    onSuffixIconPressed: isLoading ? null : onSelectDate,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final odometer = MDInputBox(
                        label: 'ODOMETER (KM)',
                        controller: odometerController,
                        hintText: '0',
                        prefixIcon: Icons.speed_outlined,
                        enabled: !isLoading,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: odometerValidator,
                      );
                      final cost = MDInputBox(
                        label: 'SERVICE COST',
                        controller: costController,
                        hintText: '0.00',
                        prefixIcon: Icons.currency_ruble_rounded,
                        enabled: !isLoading,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.next,
                        validator: costValidator,
                      );

                      if (constraints.maxWidth < 430) {
                        return Column(
                          children: [
                            odometer,
                            const SizedBox(height: 16),
                            cost,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: odometer),
                          const SizedBox(width: 12),
                          Expanded(child: cost),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  _StatusSelector(
                    selectedStatus: selectedStatus,
                    availableStatuses: availableStatuses,
                    enabled: !isLoading,
                    onSelected: onStatusChanged,
                  ),
                  const SizedBox(height: 18),
                  MDInputBox(
                    label: 'NOTES (OPTIONAL)',
                    controller: notesController,
                    hintText: 'Parts replaced, workshop, or observations',
                    prefixIcon: Icons.notes_rounded,
                    enabled: !isLoading,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => onSubmit(),
                  ),
                  const SizedBox(height: 28),
                  MDButton(
                    label: 'SAVE MAINTENANCE',
                    icon: Icons.save_outlined,
                    iconAtStart: true,
                    height: 54,
                    isLoading: isLoading,
                    onPressed: onSubmit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VehicleBanner extends StatelessWidget {
  const _VehicleBanner({required this.motorcycle});

  final MotorcycleData motorcycle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.two_wheeler_rounded,
              color: AppColors.surface,
              size: 27,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MDText(
                  '${motorcycle.brand} ${motorcycle.model}',
                  variant: MDTextVariant.titleMedium,
                  color: AppColors.surface,
                  fontWeight: FontWeight.w800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                MDText(
                  '${motorcycle.plateNumber}  •  ${motorcycle.odometerKm} KM',
                  variant: MDTextVariant.labelSmall,
                  color: AppColors.mutedText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicePicker extends StatelessWidget {
  const _ServicePicker({
    required this.services,
    required this.selectedService,
    required this.enabled,
    required this.onSelected,
  });

  final List<String> services;
  final String selectedService;
  final bool enabled;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MDText(
          'SERVICE TYPE',
          variant: MDTextVariant.labelMedium,
          letterSpacing: 1,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        PopupMenuButton<String>(
          enabled: enabled,
          initialValue: selectedService,
          constraints: const BoxConstraints(maxHeight: 280),
          onSelected: onSelected,
          itemBuilder: (context) => services
              .map(
                (service) => PopupMenuItem<String>(
                  value: service,
                  child: MDText(service, variant: MDTextVariant.bodyMedium),
                ),
              )
              .toList(growable: false),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: enabled ? AppColors.surface : AppColors.secondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.handyman_rounded, color: AppColors.neutral),
                const SizedBox(width: 12),
                Expanded(
                  child: MDText(
                    selectedService,
                    variant: MDTextVariant.bodyMedium,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusSelector extends StatelessWidget {
  const _StatusSelector({
    required this.selectedStatus,
    required this.availableStatuses,
    required this.enabled,
    required this.onSelected,
  });

  final ServiceRecordStatus selectedStatus;
  final List<ServiceRecordStatus> availableStatuses;
  final bool enabled;
  final ValueChanged<ServiceRecordStatus> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MDText(
          'SERVICE STATUS',
          variant: MDTextVariant.labelMedium,
          letterSpacing: 1,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: availableStatuses
              .map((status) {
                final selected = status == selectedStatus;
                final label = switch (status) {
                  ServiceRecordStatus.completed => 'Completed',
                  ServiceRecordStatus.inspected => 'Inspected',
                  ServiceRecordStatus.recommended => 'Recommended',
                };
                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: enabled ? (_) => onSelected(status) : null,
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surface,
                  labelStyle: TextStyle(
                    color: selected ? AppColors.surface : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  side: BorderSide(
                    color: selected ? AppColors.primary : AppColors.border,
                  ),
                  showCheckmark: false,
                );
              })
              .toList(growable: false),
        ),
      ],
    );
  }
}
