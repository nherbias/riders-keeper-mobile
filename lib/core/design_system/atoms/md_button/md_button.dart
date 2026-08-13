import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

enum MDButtonVariant { filled, outlined }

class MDButton extends StatelessWidget {
  const MDButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
    this.iconWidget,
    this.iconAtStart = false,
    this.variant = MDButtonVariant.filled,
    this.height = 45,
    this.width,
    this.horizontalPadding = 20,
    this.labelFontSize = 14,
    this.labelLetterSpacing = 2,
    this.iconSize = 22,
    this.iconSpacing = 10,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final IconData? icon;
  final Widget? iconWidget;
  final bool iconAtStart;
  final MDButtonVariant variant;
  final double height;
  final double? width;
  final double horizontalPadding;
  final double labelFontSize;
  final double labelLetterSpacing;
  final double iconSize;
  final double iconSpacing;

  @override
  Widget build(BuildContext context) {
    final canPress = enabled && !isLoading && onPressed != null;
    final foregroundColor = variant == MDButtonVariant.filled
        ? Colors.white
        : canPress
        ? AppColors.textPrimary
        : AppColors.mutedText;

    final content = isLoading
        ? SizedBox.square(
            dimension: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: foregroundColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if ((iconWidget != null || icon != null) && iconAtStart) ...[
                iconWidget ??
                    Icon(icon, color: foregroundColor, size: iconSize),
                SizedBox(width: iconSpacing),
              ],
              Flexible(
                child: MDText(
                  label,
                  variant: MDTextVariant.label,
                  overflow: TextOverflow.ellipsis,
                  color: foregroundColor,
                  fontSize: labelFontSize,
                  fontWeight: FontWeight.w700,
                  letterSpacing: labelLetterSpacing,
                ),
              ),
              if ((iconWidget != null || icon != null) && !iconAtStart) ...[
                SizedBox(width: iconSpacing),
                iconWidget ??
                    Icon(icon, color: foregroundColor, size: iconSize),
              ],
            ],
          );

    if (variant == MDButtonVariant.outlined) {
      return SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          onPressed: canPress ? onPressed : null,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.textPrimary,
            disabledBackgroundColor: AppColors.secondary,
            disabledForegroundColor: AppColors.mutedText,
            side: BorderSide(
              color: canPress ? AppColors.border : AppColors.mutedText,
            ),
            overlayColor: AppColors.secondary,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: content,
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: canPress
              ? const LinearGradient(
                  colors: [Colors.black, AppColors.textSecondary],
                )
              : null,
          color: canPress ? null : AppColors.mutedText,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: canPress ? onPressed : null,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Center(child: content),
            ),
          ),
        ),
      ),
    );
  }
}
