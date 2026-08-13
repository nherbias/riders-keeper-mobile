import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_text_styles.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class MDText extends StatelessWidget {
  const MDText(
    this.text, {
    this.variant = MDTextVariant.body,
    this.textAlign,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.decoration,
    super.key,
  });

  final String text;
  final MDTextVariant variant;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? height;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final baseStyle = switch (variant) {
      MDTextVariant.display => AppTextStyles.displayLarge,
      MDTextVariant.displayMedium => AppTextStyles.displayMedium,
      MDTextVariant.displaySmall => AppTextStyles.displaySmall,
      MDTextVariant.headline => AppTextStyles.headlineLarge,
      MDTextVariant.headlineMedium => AppTextStyles.headlineMedium,
      MDTextVariant.headlineSmall => AppTextStyles.headlineSmall,
      MDTextVariant.title => AppTextStyles.titleLarge,
      MDTextVariant.titleMedium => AppTextStyles.titleMedium,
      MDTextVariant.titleSmall => AppTextStyles.titleSmall,
      MDTextVariant.body => AppTextStyles.bodyLarge,
      MDTextVariant.bodyMedium => AppTextStyles.bodyMedium,
      MDTextVariant.bodySmall => AppTextStyles.bodySmall,
      MDTextVariant.label => AppTextStyles.labelLarge,
      MDTextVariant.labelMedium => AppTextStyles.labelMedium,
      MDTextVariant.labelSmall => AppTextStyles.labelSmall,
      MDTextVariant.caption => AppTextStyles.bodySmall,
    };

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: baseStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
      ),
    );
  }
}
