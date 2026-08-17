import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/molecules/md_dashboard_cards/md_dashboard_cards.dart';
import 'package:riders_keeper/core/design_system/organisms/md_motorcycle_hero_placeholder/md_motorcycle_hero_placeholder.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
import 'package:riders_keeper/core/types/home_dashboard_types.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';

class VehicleDetailsTemplate extends StatelessWidget {
  const VehicleDetailsTemplate({
    required this.motorcycle,
    required this.nickname,
    required this.year,
    required this.nextServiceKm,
    required this.upcomingMaintenance,
    required this.onBack,
    required this.onEdit,
    required this.onUpcomingSelected,
    required this.onViewServiceHistory,
    required this.onLogMaintenance,
    super.key,
  });

  final MotorcycleData motorcycle;
  final String nickname;
  final String year;
  final int nextServiceKm;
  final List<UpcomingItemData> upcomingMaintenance;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final ValueChanged<UpcomingItemData> onUpcomingSelected;
  final VoidCallback onViewServiceHistory;
  final VoidCallback onLogMaintenance;

  @override
  Widget build(BuildContext context) {
    return MDScaffold(
      appBarTitle: 'Vehicle Details',
      appBarLeading: IconButton(
        tooltip: 'Back to Garage',
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      appBarActions: [
        IconButton(
          tooltip: 'Edit motorcycle',
          onPressed: onEdit,
          icon: const Icon(Icons.edit_outlined),
        ),
        const SizedBox(width: 8),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _VehicleHeroOverview(
                  motorcycle: motorcycle,
                  nickname: nickname,
                  nextServiceKm: nextServiceKm,
                ),
                const SizedBox(height: 8),
                _SpecificationsCard(
                  brand: motorcycle.brand,
                  model: motorcycle.model,
                  year: year,
                  plateNumber: motorcycle.plateNumber,
                ),
                const SizedBox(height: 8),
                const _SectionHeading(
                  icon: Icons.bolt_rounded,
                  title: 'Quick actions',
                  subtitle: 'Manage this motorcycle',
                ),
                const SizedBox(height: 8),
                if (upcomingMaintenance.isNotEmpty)
                  _UpcomingMaintenanceSection(
                    items: upcomingMaintenance,
                    onSelected: onUpcomingSelected,
                  ),
                const SizedBox(height: 8),
                _ActionTile(
                  icon: Icons.history_rounded,
                  label: 'View Service History',
                  description: 'Review previous services and repairs',
                  onTap: onViewServiceHistory,
                ),
                const SizedBox(height: 8),
                _ActionTile(
                  icon: Icons.playlist_add_rounded,
                  label: 'Log New Maintenance',
                  description: 'Record completed maintenance work',
                  onTap: onLogMaintenance,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VehicleHeroOverview extends StatelessWidget {
  const _VehicleHeroOverview({
    required this.motorcycle,
    required this.nickname,
    required this.nextServiceKm,
  });

  final MotorcycleData motorcycle;
  final String nickname;
  final int nextServiceKm;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final metrics = _VehicleMetrics(
          odometerKm: motorcycle.odometerKm,
          nextServiceKm: nextServiceKm,
        );
        final hero = MDMotorcycleHeroPlaceholder(
          brand: motorcycle.brand,
          model: motorcycle.model,
          plateNumber: motorcycle.plateNumber,
          odometerKm: motorcycle.odometerKm,
          badgeLabel: motorcycle.isActive ? 'PRIMARY VEHICLE' : 'MOTORCYCLE',
          title: nickname,
          height: constraints.maxWidth < 390 ? 220 : 250,
        );
        final usesLargeText = MediaQuery.textScalerOf(context).scale(1) > 1.2;

        if (constraints.maxWidth < 390 || usesLargeText) {
          return Column(children: [hero, const SizedBox(height: 12), metrics]);
        }

        return SizedBox(
          height: 322,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              hero,
              Positioned(left: 16, right: 16, top: 212, child: metrics),
            ],
          ),
        );
      },
    );
  }
}

class _VehicleMetrics extends StatelessWidget {
  const _VehicleMetrics({
    required this.odometerKm,
    required this.nextServiceKm,
  });

  final int odometerKm;
  final int nextServiceKm;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cards = [
          _MetricCard(
            icon: Icons.speed_outlined,
            label: 'ODOMETER',
            value: _formatNumber(odometerKm),
            unit: 'KM',
          ),
          _MetricCard(
            icon: Icons.event_repeat_rounded,
            label: 'NEXT SERVICE',
            value: _formatNumber(nextServiceKm),
            unit: 'KM',
            supportingText: 'Estimated interval',
          ),
        ];

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: cards.first),
              const SizedBox(width: 8),
              Expanded(child: cards.last),
            ],
          ),
        );
      },
    );
  }

  String _formatNumber(int value) => value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    this.supportingText,
  });

  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final String? supportingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 104),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 13),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6E7E8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16, color: AppColors.surface),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MDText(
                  label,
                  variant: MDTextVariant.labelSmall,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: MDText(
                  value,
                  variant: MDTextVariant.title,
                  fontWeight: FontWeight.w800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 5),
              MDText(unit, variant: MDTextVariant.labelSmall),
            ],
          ),
          if (supportingText != null) ...[
            const SizedBox(height: 3),
            MDText(
              supportingText!,
              variant: MDTextVariant.bodySmall,
              color: AppColors.textSecondary,
            ),
          ],
        ],
      ),
    );
  }
}

class _SpecificationsCard extends StatelessWidget {
  const _SpecificationsCard({
    required this.brand,
    required this.model,
    required this.year,
    required this.plateNumber,
  });

  final String brand;
  final String model;
  final String year;
  final String plateNumber;

  @override
  Widget build(BuildContext context) {
    final specifications = [
      (icon: Icons.factory_outlined, label: 'BRAND', value: brand),
      (icon: Icons.two_wheeler_rounded, label: 'MODEL', value: model),
      (icon: Icons.calendar_today_outlined, label: 'YEAR', value: year),
      (
        icon: Icons.confirmation_number_outlined,
        label: 'PLATE',
        value: plateNumber,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE6E7E8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SectionHeading(
            icon: Icons.tune_rounded,
            title: 'Specifications',
            subtitle: 'Vehicle registration details',
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final textScale = MediaQuery.textScalerOf(context).scale(1);
              final useSingleColumn =
                  constraints.maxWidth < 360 || textScale > 1.2;

              if (useSingleColumn) {
                return Column(
                  children: [
                    for (
                      var index = 0;
                      index < specifications.length;
                      index++
                    ) ...[
                      _Specification(
                        icon: specifications[index].icon,
                        label: specifications[index].label,
                        value: specifications[index].value,
                      ),
                      if (index < specifications.length - 1)
                        const SizedBox(height: 10),
                    ],
                  ],
                );
              }

              return Column(
                children: [
                  for (
                    var index = 0;
                    index < specifications.length;
                    index += 2
                  ) ...[
                    Row(
                      children: [
                        Expanded(
                          child: _Specification(
                            icon: specifications[index].icon,
                            label: specifications[index].label,
                            value: specifications[index].value,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _Specification(
                            icon: specifications[index + 1].icon,
                            label: specifications[index + 1].label,
                            value: specifications[index + 1].value,
                          ),
                        ),
                      ],
                    ),
                    if (index < specifications.length - 2)
                      const SizedBox(height: 10),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 21),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MDText(
                title,
                variant: MDTextVariant.titleMedium,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(height: 1),
              MDText(
                subtitle,
                variant: MDTextVariant.labelSmall,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Specification extends StatelessWidget {
  const _Specification({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 19, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MDText(
                  label,
                  variant: MDTextVariant.labelSmall,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 2),
                MDText(
                  value,
                  variant: MDTextVariant.titleMedium,
                  fontWeight: FontWeight.w800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingMaintenanceSection extends StatelessWidget {
  const _UpcomingMaintenanceSection({
    required this.items,
    required this.onSelected,
  });

  final List<UpcomingItemData> items;
  final ValueChanged<UpcomingItemData> onSelected;

  @override
  Widget build(BuildContext context) {
    final nextItem = items.first;
    final visibleItems = items.take(2).toList(growable: false);
    final remainingCount = items.length - visibleItems.length;
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onSelected(nextItem),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF3A3A3A),
                    child: Icon(
                      Icons.event_repeat_rounded,
                      color: AppColors.surface,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MDText(
                          'UPCOMING MAINTENANCE',
                          variant: MDTextVariant.label,
                          color: AppColors.surface,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .6,
                        ),
                        MDText(
                          'View full calendar',
                          variant: MDTextVariant.labelSmall,
                          color: AppColors.mutedText,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.surface,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              for (var index = 0; index < visibleItems.length; index++) ...[
                MDUpcomingMaintenanceRow(
                  month: visibleItems[index].month,
                  day: visibleItems[index].day,
                  motorcycle: visibleItems[index].motorcycle,
                  service: visibleItems[index].service,
                  showChevron: false,
                  onTap: () => onSelected(visibleItems[index]),
                ),
                if (index < visibleItems.length - 1) const SizedBox(height: 8),
              ],
              if (remainingCount > 0) ...[
                const SizedBox(height: 10),
                MDText(
                  '+$remainingCount more scheduled',
                  variant: MDTextVariant.labelSmall,
                  color: AppColors.surface,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE6E7E8)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.secondary,
                child: Icon(icon, color: AppColors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MDText(
                      label,
                      variant: MDTextVariant.titleMedium,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 2),
                    MDText(
                      description,
                      variant: MDTextVariant.labelSmall,
                      color: AppColors.textSecondary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.surface,
                  size: 21,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
