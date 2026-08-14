import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/atoms/md_google_icon/md_google_icon.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(name: 'MDGoogleIcon', group: 'Design System', size: Size(180, 180))
Widget mdGoogleIconPreview() {
  return const MDWidgetPreview(child: MDGoogleIcon(size: 48));
}
