import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';
import 'package:riders_keeper/features/home/presentation/templates/needs_attention/needs_attention_template.dart';

@Preview(name: 'Needs Attention', group: 'Home', size: Size(390, 844))
Widget needsAttentionTemplatePreview() {
  return MDWidgetPreview(
    child: NeedsAttentionTemplate(
      items: const [
        AttentionItemData(
          title: 'Brake Pad Replacement',
          motorcycle: 'Ducati Panigale V4',
          detail: 'Brake Pad Replacement',
          status: 'OVERDUE',
          isCritical: true,
          icon: Icons.build,
          serviceMethod: 'SERVICE CENTER',
          urgencyLabel: '5 DAYS LATE',
        ),
        AttentionItemData(
          title: 'Engine Coolant Low',
          motorcycle: 'Ducati Panigale V4',
          detail: 'Engine Coolant Low',
          status: 'URGENT',
          isCritical: false,
          icon: Icons.oil_barrel_outlined,
          serviceMethod: 'DIY READY',
          urgencyLabel: '1 DAY LEFT',
        ),
      ],
      overdueCount: 1,
      urgentCount: 1,
      onBack: () {},
      onItemSelected: (_) {},
    ),
  );
}
