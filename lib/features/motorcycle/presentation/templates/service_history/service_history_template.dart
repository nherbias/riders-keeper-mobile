import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';
import 'package:riders_keeper/core/types/motorcycle_types.dart';
import 'package:riders_keeper/core/types/service_history_types.dart';

class ServiceHistoryTemplate extends StatelessWidget {
  const ServiceHistoryTemplate({
    required this.motorcycle,
    required this.year,
    required this.vinSuffix,
    required this.records,
    required this.totalCost,
    required this.yearlyBudget,
    required this.daysSinceLastService,
    required this.lastServiceDate,
    required this.selectedYear,
    required this.availableYears,
    required this.selectedCategory,
    required this.categories,
    required this.onBack,
    required this.onReport,
    required this.onYearChanged,
    required this.onCategoryChanged,
    required this.onRecordSelected,
    super.key,
  });

  final MotorcycleData motorcycle;
  final String year;
  final String vinSuffix;
  final List<ServiceRecordData> records;
  final double totalCost;
  final double yearlyBudget;
  final int daysSinceLastService;
  final String lastServiceDate;
  final int selectedYear;
  final List<int> availableYears;
  final String selectedCategory;
  final List<String> categories;
  final VoidCallback onBack;
  final VoidCallback onReport;
  final ValueChanged<int> onYearChanged;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<ServiceRecordData> onRecordSelected;

  @override
  Widget build(BuildContext context) {
    final budgetProgress = yearlyBudget <= 0
        ? 0.0
        : (totalCost / yearlyBudget).clamp(0.0, 1.0);

    return MDScaffold(
      appBarTitle: 'Service History',
      appBarLeading: IconButton(
        tooltip: 'Back',
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      appBarActions: [
        IconButton(
          tooltip: 'Service report',
          onPressed: onReport,
          icon: const Icon(Icons.assessment_outlined),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _MotorcycleIdentity(
                  motorcycle: motorcycle,
                  year: year,
                  vinSuffix: vinSuffix,
                ),
                const SizedBox(height: 8),
                _SummaryCards(
                  totalCost: totalCost,
                  budgetProgress: budgetProgress,
                  lastServiceDate: lastServiceDate,
                  daysSinceLastService: daysSinceLastService,
                ),
                const SizedBox(height: 15),
                _Filters(
                  selectedYear: selectedYear,
                  availableYears: availableYears,
                  selectedCategory: selectedCategory,
                  categories: categories,
                  onYearChanged: onYearChanged,
                  onCategoryChanged: onCategoryChanged,
                ),
                const SizedBox(height: 22),
                _LogHeader(recordCount: records.length),
                const SizedBox(height: 8),
                if (records.isEmpty)
                  const _EmptyHistory()
                else
                  for (var index = 0; index < records.length; index++) ...[
                    _ServiceRecordCard(
                      record: records[index],
                      onTap: () => onRecordSelected(records[index]),
                    ),
                    if (index < records.length - 1) const SizedBox(height: 10),
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MotorcycleIdentity extends StatelessWidget {
  const _MotorcycleIdentity({
    required this.motorcycle,
    required this.year,
    required this.vinSuffix,
  });

  final MotorcycleData motorcycle;
  final String year;
  final String vinSuffix;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 78,
          height: 78,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x18000000),
                blurRadius: 14,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.two_wheeler_rounded,
            color: AppColors.surface,
            size: 36,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MDText(
                '${motorcycle.brand} ${motorcycle.model}',
                variant: MDTextVariant.headlineSmall,
                fontWeight: FontWeight.w800,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              MDText(
                '$year  •  VIN $vinSuffix',
                variant: MDTextVariant.bodySmall,
                color: AppColors.textSecondary,
                letterSpacing: .6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryCards extends StatelessWidget {
  const _SummaryCards({
    required this.totalCost,
    required this.budgetProgress,
    required this.lastServiceDate,
    required this.daysSinceLastService,
  });

  final double totalCost;
  final double budgetProgress;
  final String lastServiceDate;
  final int daysSinceLastService;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _SummaryCard(
              icon: Icons.payments_outlined,
              label: 'Total maintenance',
              value: _formatPeso(totalCost),
              detail: '${(budgetProgress * 100).round()}% of yearly budget',
              progress: budgetProgress,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _SummaryCard(
              icon: Icons.event_available_outlined,
              label: 'Last service',
              value: lastServiceDate,
              detail: '$daysSinceLastService days ago',
              progress: .34,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.detail,
    required this.progress,
  });

  final IconData icon;
  final String label;
  final String value;
  final String detail;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border.withValues(alpha: .55)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: MDText(
                  label,
                  variant: MDTextVariant.labelMedium,
                  color: AppColors.textSecondary,
                  maxLines: 2,
                ),
              ),
              Icon(icon, color: AppColors.neutral, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          MDText(
            value,
            variant: MDTextVariant.titleMedium,
            fontWeight: FontWeight.w800,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              color: AppColors.primary,
              backgroundColor: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 7),
          MDText(
            detail.toUpperCase(),
            variant: MDTextVariant.labelSmall,
            color: AppColors.textSecondary,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    required this.selectedYear,
    required this.availableYears,
    required this.selectedCategory,
    required this.categories,
    required this.onYearChanged,
    required this.onCategoryChanged,
  });

  final int selectedYear;
  final List<int> availableYears;
  final String selectedCategory;
  final List<String> categories;
  final ValueChanged<int> onYearChanged;
  final ValueChanged<String> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _FilterMenu<int>(
            value: selectedYear,
            label: 'Period: $selectedYear',
            values: availableYears,
            itemLabel: (value) => value.toString(),
            onSelected: onYearChanged,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _FilterMenu<String>(
            value: selectedCategory,
            label: selectedCategory,
            values: categories,
            itemLabel: (value) => value,
            onSelected: onCategoryChanged,
            maxMenuHeight: 280,
          ),
        ),
      ],
    );
  }
}

class _FilterMenu<T> extends StatelessWidget {
  const _FilterMenu({
    required this.value,
    required this.label,
    required this.values,
    required this.itemLabel,
    required this.onSelected,
    this.maxMenuHeight,
  });

  final T value;
  final String label;
  final List<T> values;
  final String Function(T) itemLabel;
  final ValueChanged<T> onSelected;
  final double? maxMenuHeight;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      initialValue: value,
      onSelected: onSelected,
      constraints: maxMenuHeight == null
          ? null
          : BoxConstraints(maxHeight: maxMenuHeight!),
      itemBuilder: (context) => values
          .map(
            (item) => PopupMenuItem<T>(
              value: item,
              child: MDText(itemLabel(item), variant: MDTextVariant.bodyMedium),
            ),
          )
          .toList(growable: false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: MDText(
                label,
                variant: MDTextVariant.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
          ],
        ),
      ),
    );
  }
}

class _LogHeader extends StatelessWidget {
  const _LogHeader({required this.recordCount});

  final int recordCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(
            Icons.receipt_long_outlined,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 11),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MDText(
                'Maintenance log',
                variant: MDTextVariant.titleMedium,
                fontWeight: FontWeight.w800,
              ),
              MDText(
                'Completed service records',
                variant: MDTextVariant.labelSmall,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: MDText(
            '$recordCount',
            variant: MDTextVariant.labelSmall,
            color: AppColors.surface,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _ServiceRecordCard extends StatelessWidget {
  const _ServiceRecordCard({required this.record, required this.onTap});

  final ServiceRecordData record;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (record.status) {
      ServiceRecordStatus.completed => AppColors.success,
      ServiceRecordStatus.inspected => AppColors.warning,
      ServiceRecordStatus.recommended => AppColors.neutral,
    };
    final statusLabel = switch (record.status) {
      ServiceRecordStatus.completed => 'Completed',
      ServiceRecordStatus.inspected => 'Inspected',
      ServiceRecordStatus.recommended => 'Recommended',
    };

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: AppColors.border.withValues(alpha: .55)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.handyman_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MDText(
                      record.title,
                      variant: MDTextVariant.titleMedium,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 4),
                    MDText(
                      '${record.date}  •  ${_formatNumber(record.odometerKm)} KM',
                      variant: MDTextVariant.bodySmall,
                      color: AppColors.textSecondary,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MDText(
                    _formatPeso(record.cost),
                    variant: MDTextVariant.titleMedium,
                    fontWeight: FontWeight.w800,
                  ),
                  const SizedBox(height: 9),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        MDText(
                          statusLabel,
                          variant: MDTextVariant.labelSmall,
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(int value) => value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
}

String _formatPeso(double value) {
  final parts = value.toStringAsFixed(2).split('.');
  final whole = parts.first.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
  return '₱$whole.${parts.last}';
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border.withValues(alpha: .55)),
      ),
      child: const Column(
        children: [
          Icon(Icons.history_toggle_off_rounded, size: 40),
          SizedBox(height: 10),
          MDText(
            'No service records found',
            variant: MDTextVariant.titleMedium,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          MDText(
            'Try selecting a different period or service type.',
            variant: MDTextVariant.bodySmall,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
