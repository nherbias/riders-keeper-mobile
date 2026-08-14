import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/motorcycles/motorcycles_template.dart';

@Preview(name: 'Motorcycles', group: 'Motorcycle', size: Size(390, 844))
Widget motorcyclesPreview() => MDWidgetPreview(
  child: MotorcyclesTemplate(
    motorcycles: const [
      MotorcycleData(
        brand: 'Honda',
        model: 'CB650R',
        plateNumber: 'RK-2024-NEO',
        odometerKm: 12450,
        isActive: true,
      ),
    ],
    onMotorcyclePressed: (_) {},
    onAddPhotoPressed: (_) {},
    onAddMotorcyclePressed: () {},
  ),
);
