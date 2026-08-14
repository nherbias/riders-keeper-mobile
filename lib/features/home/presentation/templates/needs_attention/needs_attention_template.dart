import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/molecules/md_dashboard_cards/md_dashboard_cards.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class NeedsAttentionTemplate extends StatelessWidget {
  const NeedsAttentionTemplate({
    required this.items,
    required this.overdueCount,
    required this.urgentCount,
    required this.onBack,
    required this.onItemSelected,
    super.key,
  });

  final List<AttentionItemData> items;
  final int overdueCount;
  final int urgentCount;
  final VoidCallback onBack;
  final ValueChanged<AttentionItemData> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Needs Attention',
      appBarLeading: IconButton(
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          _AttentionOverview(
            total: items.length,
            overdue: overdueCount,
            urgent: urgentCount,
          ),
          const SizedBox(height: 22),
          const MDText(
            'Maintenance requiring action',
            variant: MDTextVariant.titleMedium,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 4),
          const MDText(
            'Prioritize overdue services to keep every ride road-ready.',
            variant: MDTextVariant.bodySmall,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 14),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: MDAttentionCard(
                motorcycle: item.title ?? item.motorcycle,
                detail: item.motorcycle,
                status: item.status,
                isCritical: item.isCritical,
                urgencyLabel: item.urgencyLabel,
                onTap: () => onItemSelected(item),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttentionOverview extends StatelessWidget {
  const _AttentionOverview({
    required this.total,
    required this.overdue,
    required this.urgent,
  });
  final int total;
  final int overdue;
  final int urgent;

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
            child: Icon(Icons.priority_high, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MDText(
                  'Action overview',
                  variant: MDTextVariant.titleMedium,
                  color: AppColors.surface,
                ),
                MDText(
                  '$total maintenance items',
                  variant: MDTextVariant.bodySmall,
                  color: AppColors.mutedText,
                ),
              ],
            ),
          ),
          _Count(value: overdue, label: 'OVERDUE', color: AppColors.error),
          const SizedBox(width: 12),
          _Count(value: urgent, label: 'URGENT', color: AppColors.warning),
        ],
      ),
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.value, required this.label, required this.color});
  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      MDText(
        '$value',
        variant: MDTextVariant.title,
        color: color,
        fontWeight: FontWeight.w800,
      ),
      MDText(
        label,
        variant: MDTextVariant.labelSmall,
        color: AppColors.mutedText,
        fontSize: 9,
      ),
    ],
  );
}
