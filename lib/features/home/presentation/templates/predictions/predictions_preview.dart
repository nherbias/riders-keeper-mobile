import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';
import 'package:riders_keeper/features/home/presentation/templates/predictions/predictions_template.dart';

@Preview(name: 'Maintenance Predictions', group: 'Home', size: Size(390, 844))
Widget predictionsTemplatePreview() {
  return MDWidgetPreview(
    child: PredictionsTemplate(
      items: const [
        PredictionItemData(
          motorcycle: 'Honda Click 125',
          detail: 'Oil Change: ~450 km remaining',
          progress: .75,
        ),
        PredictionItemData(
          motorcycle: 'Honda PCX',
          detail: 'Tire Replacement: ~20 days',
          progress: .90,
        ),
        PredictionItemData(
          motorcycle: 'Yamaha Mio',
          detail: 'Brake Inspection: ~320 km remaining',
          progress: .64,
        ),
      ],
      onBack: () {},
      onItemSelected: (_) {},
    ),
  );
}
