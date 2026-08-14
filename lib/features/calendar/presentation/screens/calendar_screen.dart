import 'package:flutter/material.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) =>
      const MDScaffold(appBarTitle: 'Calendar', body: SizedBox());
}
