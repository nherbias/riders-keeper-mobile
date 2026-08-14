import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/molecules/md_floating_action_button/md_floating_action_button.dart';
import 'package:riders_keeper/core/design_system/molecules/md_motorcycle_card/md_motorcycle_card.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';

class MotorcyclesTemplate extends StatelessWidget {
  const MotorcyclesTemplate({
    required this.motorcycles,
    required this.onMotorcyclePressed,
    required this.onAddPhotoPressed,
    required this.onAddMotorcyclePressed,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    super.key,
  });

  final List<MotorcycleData> motorcycles;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<MotorcycleData> onMotorcyclePressed;
  final ValueChanged<MotorcycleData> onAddPhotoPressed;
  final VoidCallback onAddMotorcyclePressed;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Garage',
      appBarLeading: const Icon(Icons.two_wheeler),
      floatingActionButton: MDFloatingActionButton(
        label: 'Add Motorcycle',
        onPressed: onAddMotorcyclePressed,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 104),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const MDText(
                    'Manage your registered motorcycles and maintenance logs.',
                    variant: MDTextVariant.body,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isLoading)
                    const MDMotorcycleLoadingState()
                  else if (errorMessage != null)
                    MDMotorcycleErrorState(
                      message: errorMessage!,
                      onRetry: onRetry ?? () {},
                    )
                  else if (motorcycles.isEmpty)
                    const MDMotorcycleEmptyState()
                  else
                    for (final motorcycle in motorcycles) ...[
                      MDMotorcycleCard(
                        brand: motorcycle.brand,
                        model: motorcycle.model,
                        plateNumber: motorcycle.plateNumber,
                        odometerKm: motorcycle.odometerKm,
                        imageAsset: motorcycle.imageAsset,
                        isActive: motorcycle.isActive,
                        onTap: () => onMotorcyclePressed(motorcycle),
                        onAddPhoto: () => onAddPhotoPressed(motorcycle),
                      ),
                      const SizedBox(height: 16),
                    ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
