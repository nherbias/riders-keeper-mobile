import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/molecules/md_dashboard_cards/md_dashboard_cards.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(name: 'MDDashboardCards', group: 'Design System', size: Size(390, 500))
Widget mdDashboardCardsPreview() => MDWidgetPreview(
  padding: const EdgeInsets.all(20),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      MDAttentionCard(
        motorcycle: 'Yamaha Mio',
        detail: 'Brake Inspection • Overdue by 3 days',
        status: 'CRITICAL',
        isCritical: true,
        urgencyLabel: '3 DAYS LATE',
        onTap: () {},
      ),
      const SizedBox(height: 16),
      MDPredictionCard(
        motorcycle: 'Honda Click 125',
        detail: 'Oil Change: ~450 km remaining',
        progress: .75,
        onTap: () {},
      ),
    ],
  ),
);
