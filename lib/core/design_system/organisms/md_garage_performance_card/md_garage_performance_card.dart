import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class MDGaragePerformanceCard extends StatelessWidget {
  const MDGaragePerformanceCard({
    required this.health,
    required this.total,
    required this.healthy,
    required this.overdue,
    super.key,
  });

  final int health;
  final int total;
  final int healthy;
  final int overdue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surface, width: 4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MDText(
                  '$health%',
                  variant: MDTextVariant.title,
                  color: AppColors.surface,
                  fontWeight: FontWeight.w800,
                ),
                const MDText(
                  'HEALTH',
                  variant: MDTextVariant.labelSmall,
                  color: AppColors.mutedText,
                  letterSpacing: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const MDText(
                  'Garage Performance',
                  variant: MDTextVariant.titleSmall,
                  color: AppColors.surface,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _Metric(value: total, label: 'TOTAL'),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: _Metric(
                        value: healthy,
                        label: 'HEALTHY',
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: _Metric(
                        value: overdue,
                        label: 'OVERDUE',
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label, this.color});

  final int value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF303030)),
      ),
      child: Column(
        children: [
          MDText(
            '$value',
            variant: MDTextVariant.titleSmall,
            color: color ?? AppColors.surface,
          ),
          const SizedBox(height: 2),
          MDText(
            label,
            variant: MDTextVariant.labelSmall,
            fontSize: 9,
            color: AppColors.mutedText,
          ),
        ],
      ),
    );
  }
}
