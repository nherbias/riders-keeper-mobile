import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:riders_keeper/core/design_system/atoms/md_input_box/md_input_box.dart';
import 'package:riders_keeper/core/design_system/templates/md_widget_preview/md_widget_preview.dart';

@Preview(name: 'MDInputBox', group: 'Design System', size: Size(390, 250))
Widget mdInputBoxPreview() {
  return const MDWidgetPreview(
    padding: EdgeInsets.all(24),
    child: _MDInputBoxPreview(),
  );
}

class _MDInputBoxPreview extends StatefulWidget {
  const _MDInputBoxPreview();

  @override
  State<_MDInputBoxPreview> createState() => _MDInputBoxPreviewState();
}

class _MDInputBoxPreviewState extends State<_MDInputBoxPreview> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MDInputBox(
      label: 'EMAIL OR USERNAME',
      controller: _controller,
      hintText: 'Enter your email or username',
      prefixIcon: Icons.badge_outlined,
    );
  }
}
