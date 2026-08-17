import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/organisms/md_motorcycle_hero_placeholder/md_motorcycle_hero_placeholder.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
import 'package:riders_keeper/core/types/motorcycle_draft.dart';

class ReviewMotorcycleTemplate extends StatelessWidget {
  const ReviewMotorcycleTemplate({
    required this.draft,
    required this.isLoading,
    required this.onBack,
    required this.onEditDetails,
    required this.onConfirm,
    super.key,
  });

  final MotorcycleDraft draft;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onEditDetails;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Review Details',
      appBarLeading: IconButton(
        tooltip: 'Back to edit details',
        onPressed: isLoading ? null : onBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MDMotorcycleHeroPlaceholder(
                  brand: draft.brand,
                  model: draft.model,
                  plateNumber: draft.plateNumber,
                  odometerKm: draft.odometerKm,
                  badgeLabel: 'VEHICLE PHOTO',
                ),
                const SizedBox(height: 24),
                _TechnicalProfile(draft: draft),
                const SizedBox(height: 20),
                const _ReviewNotice(),
                const SizedBox(height: 24),
                MDButton(
                  label: 'CONFIRM & ADD TO GARAGE',
                  icon: Icons.add_circle_rounded,
                  iconAtStart: true,
                  height: 56,
                  isLoading: isLoading,
                  onPressed: onConfirm,
                ),
                const SizedBox(height: 12),
                MDButton(
                  label: 'EDIT DETAILS',
                  icon: Icons.edit_outlined,
                  iconAtStart: true,
                  variant: MDButtonVariant.outlined,
                  enabled: !isLoading,
                  onPressed: onEditDetails,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TechnicalProfile extends StatelessWidget {
  const _TechnicalProfile({required this.draft});

  final MotorcycleDraft draft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MDText(
            'Technical Profile',
            variant: MDTextVariant.headlineSmall,
            fontWeight: FontWeight.w800,
          ),
          const SizedBox(height: 20),
          _ProfileRow(label: 'Brand / Make', value: draft.brand),
          _ProfileRow(label: 'Model', value: draft.model),
          _ProfileRow(label: 'Year', value: draft.year),
          _ProfileRow(label: 'Plate Number', value: draft.plateNumber),
          _ProfileRow(
            label: 'Current Odometer',
            value: '${_formatNumber(draft.odometerKm)} km',
          ),
          _ProfileRow(
            label: 'Nickname',
            value: draft.nickname.isEmpty ? 'Not provided' : draft.nickname,
            showDivider: false,
          ),
        ],
      ),
    );
  }

  String _formatNumber(int value) => value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MDText(
                  label,
                  variant: MDTextVariant.bodyMedium,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: MDText(
                  value,
                  variant: MDTextVariant.titleMedium,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1, color: AppColors.border),
      ],
    );
  }
}

class _ReviewNotice extends StatelessWidget {
  const _ReviewNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: AppColors.textSecondary),
          SizedBox(width: 12),
          Expanded(
            child: MDText(
              'Please ensure all details are correct. You can update the odometer and service history at any time from the garage.',
              variant: MDTextVariant.bodyMedium,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
