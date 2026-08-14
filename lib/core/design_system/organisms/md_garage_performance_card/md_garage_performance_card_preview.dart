import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/organisms/md_garage_performance_card/md_garage_performance_card.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(
  name: 'MDGaragePerformanceCard',
  group: 'Design System',
  size: Size(390, 540),
)
Widget mdGaragePerformanceCardPreview() {
  return const MDWidgetPreview(
    padding: EdgeInsets.all(20),
    child: MDGaragePerformanceCard(
      health: 87,
      total: 5,
      healthy: 3,
      overdue: 1,
    ),
  );
}
