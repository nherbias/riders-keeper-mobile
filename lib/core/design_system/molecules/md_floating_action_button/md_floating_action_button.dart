import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class MDFloatingActionButton extends StatelessWidget {
  const MDFloatingActionButton({
    required this.label,
    required this.onPressed,
    this.icon = Icons.add_rounded,
    this.supportingText,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData icon;
  final String? supportingText;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 360;

    return Tooltip(
      message: label,
      child: Semantics(
        button: true,
        label: label,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF333333), AppColors.primary],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: .22),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: compact
                    ? const EdgeInsets.all(7)
                    : const EdgeInsets.fromLTRB(7, 7, 18, 7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: AppColors.primary, size: 25),
                    ),
                    if (!compact) ...[
                      const SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MDText(
                            label,
                            variant: MDTextVariant.label,
                            color: AppColors.surface,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .2,
                          ),
                          if (supportingText != null)
                            MDText(
                              supportingText!,
                              variant: MDTextVariant.labelSmall,
                              color: AppColors.surface,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              letterSpacing: .3,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
