import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/core/types/motorcycle_draft.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/review_motorcycle/review_motorcycle_template.dart';

@Preview(name: 'Review Motorcycle', group: 'Motorcycle', size: Size(390, 844))
Widget reviewMotorcyclePreview() => MDWidgetPreview(
  child: ReviewMotorcycleTemplate(
    draft: const MotorcycleDraft(
      brand: 'Ducati',
      model: 'Panigale V4',
      year: '2024',
      plateNumber: 'IT-93-RED',
      odometerKm: 0,
      nickname: 'My Beast',
    ),
    isLoading: false,
    onBack: () {},
    onEditDetails: () {},
    onConfirm: () {},
  ),
);
