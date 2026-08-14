import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/molecules/md_motorcycle_card/md_motorcycle_card.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(name: 'MDMotorcycleCard', group: 'Design System', size: Size(390, 650))
Widget mdMotorcycleCardPreview() => MDWidgetPreview(
  padding: const EdgeInsets.all(20),
  child: SingleChildScrollView(
    child: MDMotorcycleCard(
      brand: 'Honda',
      model: 'CB650R',
      plateNumber: 'RK-2024-NEO',
      odometerKm: 12450,
      isActive: true,
      onTap: () {},
    ),
  ),
);

@Preview(
  name: 'MDMotorcycleEmptyState',
  group: 'Design System',
  size: Size(390, 500),
)
Widget mdMotorcycleEmptyStatePreview() => const MDWidgetPreview(
  padding: EdgeInsets.all(20),
  child: MDMotorcycleEmptyState(),
);

@Preview(
  name: 'MDMotorcycleLoadingState',
  group: 'Design System',
  size: Size(390, 360),
)
Widget mdMotorcycleLoadingStatePreview() => const MDWidgetPreview(
  padding: EdgeInsets.all(20),
  child: MDMotorcycleLoadingState(),
);

@Preview(
  name: 'MDMotorcycleErrorState',
  group: 'Design System',
  size: Size(390, 440),
)
Widget mdMotorcycleErrorStatePreview() => MDWidgetPreview(
  padding: const EdgeInsets.all(20),
  child: MDMotorcycleErrorState(
    message: 'Check your connection and try again.',
    onRetry: () {},
  ),
);
