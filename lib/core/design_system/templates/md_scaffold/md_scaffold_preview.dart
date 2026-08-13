import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(name: 'MDScaffold', group: 'Design System', size: Size(390, 844))
Widget mdScaffoldPreview() {
  return const MDWidgetPreview(
    child: MDScaffold(body: Center(child: Text('MDScaffold content'))),
  );
}
