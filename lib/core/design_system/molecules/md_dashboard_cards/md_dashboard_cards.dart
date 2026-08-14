import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class MDAttentionCard extends StatelessWidget {
  const MDAttentionCard({
    required this.motorcycle,
    required this.detail,
    required this.status,
    required this.isCritical,
    required this.onTap,
    this.showAdditionalDetails = false,
    this.title,
    this.icon = Icons.warning_amber_rounded,
    this.estimatedCost,
    this.serviceMethod,
    this.urgencyLabel,
    super.key,
  });
  final String motorcycle;
  final String detail;
  final String status;
  final bool isCritical;
  final VoidCallback onTap;
  final bool showAdditionalDetails;
  final String? title;
  final IconData icon;
  final String? estimatedCost;
  final String? serviceMethod;
  final String? urgencyLabel;

  @override
  Widget build(BuildContext context) {
    final color = isCritical ? AppColors.error : AppColors.warning;
    if (showAdditionalDetails) {
      return _DetailedAttentionCard(
        motorcycle: motorcycle,
        title: title ?? detail,
        status: status,
        estimatedCost: estimatedCost,
        serviceMethod: serviceMethod,
        urgencyLabel: urgencyLabel,
        color: color,
        onTap: onTap,
      );
    }
    return _DashboardCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: color),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MDText(motorcycle, variant: MDTextVariant.titleMedium),
                MDText(detail, variant: MDTextVariant.bodyMedium),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MDText(
                status,
                variant: MDTextVariant.labelSmall,
                color: color,
                fontWeight: FontWeight.w700,
              ),
              if (urgencyLabel != null) ...[
                const SizedBox(height: 3),
                MDText(
                  urgencyLabel!,
                  variant: MDTextVariant.labelSmall,
                  color: AppColors.textSecondary,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailedAttentionCard extends StatelessWidget {
  const _DetailedAttentionCard({
    required this.motorcycle,
    required this.title,
    required this.status,
    required this.estimatedCost,
    required this.serviceMethod,
    required this.urgencyLabel,
    required this.color,
    required this.onTap,
  });

  final String motorcycle;
  final String title;
  final String status;
  final String? estimatedCost;
  final String? serviceMethod;
  final String? urgencyLabel;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(width: 4, color: color),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              status == 'OVERDUE'
                                  ? Icons.error_outline
                                  : Icons.warning_amber_rounded,
                              color: color,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MDText(
                                    title,
                                    variant: MDTextVariant.titleSmall,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  const SizedBox(height: 2),
                                  MDText(
                                    motorcycle,
                                    variant: MDTextVariant.bodySmall,
                                    color: AppColors.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: .13),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: MDText(
                                    status,
                                    variant: MDTextVariant.labelSmall,
                                    color: color,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                if (urgencyLabel != null) ...[
                                  const SizedBox(height: 5),
                                  MDText(
                                    urgencyLabel!,
                                    variant: MDTextVariant.labelSmall,
                                    color: color,
                                    fontWeight: FontWeight.w800,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                        if (estimatedCost != null || serviceMethod != null) ...[
                          const SizedBox(height: 8),
                          const Divider(height: 1, color: AppColors.border),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              if (estimatedCost != null)
                                Expanded(
                                  child: _Detail(
                                    icon: Icons.payments_outlined,
                                    text: estimatedCost!,
                                  ),
                                ),
                              if (serviceMethod != null)
                                Expanded(
                                  child: _Detail(
                                    icon: Icons.location_on_outlined,
                                    text: serviceMethod!,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        MDText(text, variant: MDTextVariant.labelSmall),
      ],
    );
  }
}

class MDPredictionCard extends StatelessWidget {
  const MDPredictionCard({
    required this.motorcycle,
    required this.detail,
    required this.progress,
    required this.onTap,
    super.key,
  });
  final String motorcycle;
  final String detail;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      onTap: onTap,
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, size: 24, color: AppColors.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MDText(motorcycle, variant: MDTextVariant.titleMedium),
                MDText(detail, variant: MDTextVariant.bodyMedium),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    color: AppColors.primary,
                    backgroundColor: AppColors.border,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const MDText(
            'AI',
            variant: MDTextVariant.labelSmall,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}

class MDUpcomingMaintenanceRow extends StatelessWidget {
  const MDUpcomingMaintenanceRow({
    required this.month,
    required this.day,
    required this.motorcycle,
    required this.service,
    required this.onTap,
    super.key,
  });
  final String month;
  final String day;
  final String motorcycle;
  final String service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                MDText(month, variant: MDTextVariant.labelSmall),
                MDText(day, variant: MDTextVariant.titleMedium),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MDText(motorcycle, variant: MDTextVariant.titleMedium),
                MDText(service, variant: MDTextVariant.bodyMedium),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.neutral),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.child, required this.onTap});
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 82),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: child,
          ),
        ),
      ),
    );
  }
}
