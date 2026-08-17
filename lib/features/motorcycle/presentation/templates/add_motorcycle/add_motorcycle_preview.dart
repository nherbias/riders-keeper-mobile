import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/features/motorcycle/presentation/templates/add_motorcycle/add_motorcycle_template.dart';

@Preview(name: 'Add Motorcycle', group: 'Motorcycle', size: Size(390, 844))
Widget addMotorcyclePreview() => MDWidgetPreview(
  child: AddMotorcycleTemplate(
    appBarTitle: 'Add Motorcycle',
    submitLabel: 'ADD TO GARAGE',
    submitIcon: Icons.two_wheeler_rounded,
    formKey: GlobalKey<FormState>(),
    brandController: TextEditingController(),
    modelController: TextEditingController(),
    yearController: TextEditingController(),
    plateNumberController: TextEditingController(),
    odometerController: TextEditingController(),
    nicknameController: TextEditingController(),
    isLoading: false,
    hasSelectedPhoto: false,
    brandValidator: (_) => null,
    modelValidator: (_) => null,
    yearValidator: (_) => null,
    plateNumberValidator: (_) => null,
    odometerValidator: (_) => null,
    onSelectPhoto: () {},
    onBack: () {},
    onSubmit: () {},
  ),
);
