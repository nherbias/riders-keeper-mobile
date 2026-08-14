import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/molecules/md_dashboard_cards/md_dashboard_cards.dart';
import 'package:riders_keeper/core/design_system/molecules/md_section_header/md_section_header.dart';
import 'package:riders_keeper/core/design_system/organisms/md_garage_performance_card/md_garage_performance_card.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';

class HomeTemplate extends StatelessWidget {
  const HomeTemplate({
    required this.userName,
    required this.garageSummary,
    required this.attentionItems,
    required this.predictionItems,
    required this.upcomingItems,
    required this.onViewAttention,
    required this.onViewPredictions,
    required this.onViewCalendar,
    required this.onAttentionSelected,
    required this.onPredictionSelected,
    required this.onUpcomingSelected,
    super.key,
  });

  final String userName;
  final GarageSummaryData garageSummary;
  final List<AttentionItemData> attentionItems;
  final List<PredictionItemData> predictionItems;
  final List<UpcomingItemData> upcomingItems;
  final VoidCallback onViewAttention;
  final VoidCallback onViewPredictions;
  final VoidCallback onViewCalendar;
  final ValueChanged<AttentionItemData> onAttentionSelected;
  final ValueChanged<PredictionItemData> onPredictionSelected;
  final ValueChanged<UpcomingItemData> onUpcomingSelected;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Riders Keeper',
      appBarLeading: const Icon(Icons.two_wheeler),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MDText(
                  'Hello, $userName',
                  variant: MDTextVariant.headline,
                  fontWeight: FontWeight.w800,
                ),
                const MDText(
                  "Here's your maintenance overview.",
                  variant: MDTextVariant.body,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 20),
                MDGaragePerformanceCard(
                  health: garageSummary.health,
                  total: garageSummary.total,
                  healthy: garageSummary.healthy,
                  overdue: garageSummary.overdue,
                ),
                if (attentionItems.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  MDSectionHeader(
                    title: 'Needs Attention',
                    actionLabel: 'View All',
                    onAction: onViewAttention,
                  ),
                  const SizedBox(height: 10),
                  ...attentionItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: MDAttentionCard(
                        motorcycle: item.motorcycle,
                        detail: item.detail,
                        status: item.status,
                        isCritical: item.isCritical,
                        urgencyLabel: item.urgencyLabel,
                        onTap: () => onAttentionSelected(item),
                      ),
                    ),
                  ),
                ],
                if (predictionItems.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  MDSectionHeader(
                    title: 'Prediction',
                    actionLabel: 'View Predictions',
                    onAction: onViewPredictions,
                  ),
                  const SizedBox(height: 10),
                  ...predictionItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: MDPredictionCard(
                        motorcycle: item.motorcycle,
                        detail: item.detail,
                        progress: item.progress,
                        onTap: () => onPredictionSelected(item),
                      ),
                    ),
                  ),
                ],
                if (upcomingItems.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  MDSectionHeader(
                    title: 'Upcoming',
                    actionLabel: 'View Calendar',
                    onAction: onViewCalendar,
                  ),
                  const SizedBox(height: 10),
                  ...upcomingItems.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: MDUpcomingMaintenanceRow(
                        month: item.month,
                        day: item.day,
                        motorcycle: item.motorcycle,
                        service: item.service,
                        onTap: () => onUpcomingSelected(item),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
