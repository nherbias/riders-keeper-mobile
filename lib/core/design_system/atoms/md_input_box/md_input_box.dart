import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/constants/theme/app_text_styles.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class MDInputBox extends StatelessWidget {
  const MDInputBox({
    required this.label,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onSubmitted,
    this.autofillHints,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool obscureText;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    const enabledBorderSide = BorderSide(color: AppColors.border);
    const focusedBorderSide = BorderSide(color: AppColors.primary, width: 1.5);
    const errorBorderSide = BorderSide(color: AppColors.error);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MDText(
          label,
          variant: MDTextVariant.labelMedium,
          letterSpacing: 1,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: AppTextStyles.bodyLarge,
          cursorColor: AppColors.primary,
          obscureText: obscureText,
          enabled: enabled,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          validator: validator,
          onFieldSubmitted: onSubmitted,
          autofillHints: autofillHints,
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? AppColors.surface : AppColors.secondary,
            hintText: hintText,
            hintStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            errorStyle: AppTextStyles.bodySmall.copyWith(
              color: AppColors.error,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, color: AppColors.neutral),
            suffixIcon: suffixIcon == null
                ? null
                : IconButton(
                    onPressed: onSuffixIconPressed,
                    color: AppColors.neutral,
                    disabledColor: AppColors.mutedText,
                    icon: Icon(suffixIcon),
                  ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: enabledBorderSide,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: focusedBorderSide,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: errorBorderSide,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: AppColors.mutedText),
            ),
          ),
        ),
      ],
    );
  }
}
