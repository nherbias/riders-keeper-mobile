import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/features/home/presentation/templates/home/home_template.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';

@Preview(name: 'Home', group: 'Home', size: Size(390, 844))
Widget homeTemplatePreview() {
  return MDWidgetPreview(
    child: HomeTemplate(
      userName: 'Niko',
      garageSummary: const GarageSummaryData(
        health: 87,
        total: 5,
        healthy: 3,
        overdue: 1,
      ),
      attentionItems: const [
        AttentionItemData(
          motorcycle: 'Yamaha Mio',
          detail: 'Brake Inspection',
          status: 'CRITICAL',
          isCritical: true,
          urgencyLabel: '3 DAYS LATE',
        ),
      ],
      predictionItems: const [
        PredictionItemData(
          motorcycle: 'Honda Click 125',
          detail: 'Oil Change: ~450 km remaining',
          progress: .75,
        ),
      ],
      upcomingItems: const [
        UpcomingItemData(
          month: 'JUL',
          day: '30',
          motorcycle: 'Honda Click 125',
          service: 'OIL CHANGE',
        ),
      ],
      onViewAttention: () {},
      onViewPredictions: () {},
      onViewCalendar: () {},
      onAttentionSelected: (_) {},
      onPredictionSelected: (_) {},
      onUpcomingSelected: (_) {},
    ),
  );
}
