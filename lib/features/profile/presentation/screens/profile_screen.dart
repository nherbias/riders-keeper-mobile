import 'package:flutter/material.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) =>
      const MDScaffold(appBarTitle: 'Profile', body: SizedBox());
}
