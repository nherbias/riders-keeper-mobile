import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/organisms/md_home_bottom_navigation/md_home_bottom_navigation.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(
  name: 'MDHomeBottomNavigation',
  group: 'Design System',
  size: Size(390, 160),
)
Widget mdHomeBottomNavigationPreview() {
  return MDWidgetPreview(
    alignment: Alignment.bottomCenter,
    child: MDHomeBottomNavigation(
      currentIndex: 0,
      onDestinationSelected: (_) {},
    ),
  );
}
