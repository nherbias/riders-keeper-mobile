import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_theme.dart';

class MDWidgetPreview extends StatelessWidget {
  const MDWidgetPreview({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Material(
        child: SafeArea(
          child: Padding(
            padding: padding,
            child: Align(alignment: alignment, child: child),
          ),
        ),
      ),
    );
  }
}
