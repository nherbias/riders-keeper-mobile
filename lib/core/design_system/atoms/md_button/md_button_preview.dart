import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(name: 'MDButton', group: 'Design System', size: Size(390, 300))
Widget mdButtonPreview() {
  return MDWidgetPreview(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MDButton(label: 'LOG IN', icon: Icons.login, onPressed: () {}),
        const SizedBox(height: 16),
        MDButton(
          label: 'CREATE AN ACCOUNT',
          variant: MDButtonVariant.outlined,
          onPressed: () {},
        ),
      ],
    ),
  );
}
