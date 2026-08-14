import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/molecules/md_section_header/md_section_header.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(name: 'MDSectionHeader', group: 'Design System', size: Size(390, 140))
Widget mdSectionHeaderPreview() => MDWidgetPreview(
  padding: const EdgeInsets.all(20),
  child: MDSectionHeader(
    title: 'Needs Attention',
    actionLabel: 'View All',
    onAction: () {},
  ),
);
