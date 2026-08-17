import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/organisms/md_motorcycle_hero_placeholder/md_motorcycle_hero_placeholder.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(
  name: 'MDMotorcycleHeroPlaceholder',
  group: 'Design System',
  size: Size(390, 300),
)
Widget mdMotorcycleHeroPlaceholderPreview() => const MDWidgetPreview(
  padding: EdgeInsets.all(20),
  child: MDMotorcycleHeroPlaceholder(
    brand: 'Ducati',
    model: 'Panigale V4',
    plateNumber: 'RD-KPR-01',
    odometerKm: 1250,
    badgeLabel: 'PRIMARY VEHICLE',
    title: 'The Red Beast',
  ),
);
