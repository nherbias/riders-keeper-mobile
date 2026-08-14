import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/molecules/md_floating_action_button/md_floating_action_button.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(
  name: 'MDFloatingActionButton',
  group: 'Design System',
  size: Size(300, 160),
)
Widget mdFloatingActionButtonPreview() => MDWidgetPreview(
  padding: const EdgeInsets.all(24),
  child: Align(
    alignment: Alignment.bottomRight,
    child: MDFloatingActionButton(
      label: 'Add Vehicle',
      supportingText: 'Register a motorcycle',
      onPressed: () {},
    ),
  ),
);
