import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

@Preview(name: 'MDText', group: 'Design System', size: Size(390, 420))
Widget mdTextPreview() {
  return const MDWidgetPreview(
    padding: EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MDText('Display', variant: MDTextVariant.display),
        MDText('Headline', variant: MDTextVariant.headline),
        MDText('Title', variant: MDTextVariant.title),
        MDText('Body text'),
        MDText('Small body text', variant: MDTextVariant.bodySmall),
        MDText('LABEL', variant: MDTextVariant.label),
        MDText('Caption', variant: MDTextVariant.caption),
      ],
    ),
  );
}
