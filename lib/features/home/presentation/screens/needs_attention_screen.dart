import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riders_keeper/config/router/app_router.dart';
import 'package:riders_keeper/config/router/app_routes.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';
import 'package:riders_keeper/features/home/presentation/templates/needs_attention/needs_attention_template.dart';

class NeedsAttentionScreen extends ConsumerStatefulWidget {
  const NeedsAttentionScreen({super.key});

  @override
  ConsumerState<NeedsAttentionScreen> createState() =>
      _NeedsAttentionScreenState();
}

class _NeedsAttentionScreenState extends ConsumerState<NeedsAttentionScreen> {
  final _items = const <AttentionItemData>[
    AttentionItemData(
      title: 'Brake Pad Replacement',
      motorcycle: 'Ducati Panigale V4',
      detail: 'Brake Pad Replacement',
      status: 'OVERDUE',
      isCritical: true,
      icon: Icons.build,
      serviceMethod: 'SERVICE CENTER',
      urgencyLabel: '5 DAYS LATE',
    ),
    AttentionItemData(
      title: 'Engine Coolant Low',
      motorcycle: 'Ducati Panigale V4',
      detail: 'Engine Coolant Low',
      status: 'URGENT',
      isCritical: false,
      icon: Icons.oil_barrel_outlined,
      serviceMethod: 'DIY READY',
      urgencyLabel: '1 DAY LEFT',
    ),
    AttentionItemData(
      title: 'Tire Tread Wear',
      motorcycle: 'Ducati Panigale V4 (Rear)',
      detail: 'Tire Tread Wear',
      status: 'OVERDUE',
      isCritical: true,
      icon: Icons.tire_repair,
      serviceMethod: 'SERVICE CENTER',
      urgencyLabel: '2 DAYS LATE',
    ),
    AttentionItemData(
      title: 'Battery Health Low',
      motorcycle: 'Ducati Panigale V4',
      detail: 'Battery Health Low',
      status: 'URGENT',
      isCritical: false,
      icon: Icons.battery_alert,
      serviceMethod: 'DIY READY',
      urgencyLabel: '3 DAYS LEFT',
    ),
  ];

  void _openItem(AttentionItemData item) {
    // TODO: Navigate to the maintenance detail when its route is available.
  }

  @override
  Widget build(BuildContext context) {
    final overdueCount = _items.where((item) => item.isCritical).length;
    final urgentCount = _items.length - overdueCount;

    return NeedsAttentionTemplate(
      items: _items,
      overdueCount: overdueCount,
      urgentCount: urgentCount,
      onBack: () => ref.read(appRouterProvider).go(AppRoutes.home),
      onItemSelected: _openItem,
    );
  }
}
