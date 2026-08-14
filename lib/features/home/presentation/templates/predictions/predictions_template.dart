import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/molecules/md_dashboard_cards/md_dashboard_cards.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';

class PredictionsTemplate extends StatelessWidget {
  const PredictionsTemplate({
    required this.items,
    required this.onBack,
    required this.onItemSelected,
    super.key,
  });

  final List<PredictionItemData> items;
  final VoidCallback onBack;
  final ValueChanged<PredictionItemData> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Maintenance Predictions',
      appBarLeading: IconButton(
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          _PredictionOverview(count: items.length),
          const SizedBox(height: 22),
          const MDText(
            'AI maintenance forecast',
            variant: MDTextVariant.titleMedium,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 4),
          const MDText(
            'Estimated service needs based on mileage, time, and ride history.',
            variant: MDTextVariant.bodySmall,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 14),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: MDPredictionCard(
                motorcycle: item.motorcycle,
                detail: item.detail,
                progress: item.progress,
                onTap: () => onItemSelected(item),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PredictionOverview extends StatelessWidget {
  const _PredictionOverview({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.surface,
            child: Icon(Icons.auto_awesome, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MDText(
                  'Prediction overview',
                  variant: MDTextVariant.titleMedium,
                  color: AppColors.surface,
                ),
                MDText(
                  'Plan maintenance before it becomes urgent',
                  variant: MDTextVariant.bodySmall,
                  color: AppColors.mutedText,
                ),
              ],
            ),
          ),
          Column(
            children: [
              MDText(
                '$count',
                variant: MDTextVariant.title,
                color: AppColors.surface,
                fontWeight: FontWeight.w800,
              ),
              const MDText(
                'FORECASTS',
                variant: MDTextVariant.labelSmall,
                color: AppColors.mutedText,
                fontSize: 9,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
