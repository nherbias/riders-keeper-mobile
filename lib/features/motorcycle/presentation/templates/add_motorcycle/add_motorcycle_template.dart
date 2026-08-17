import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_input_box/md_input_box.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/templates/md_scaffold/md_scaffold.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class AddMotorcycleTemplate extends StatelessWidget {
  const AddMotorcycleTemplate({
    required this.appBarTitle,
    required this.submitLabel,
    required this.submitIcon,
    required this.formKey,
    required this.brandController,
    required this.modelController,
    required this.yearController,
    required this.plateNumberController,
    required this.odometerController,
    required this.nicknameController,
    required this.isLoading,
    required this.hasSelectedPhoto,
    required this.brandValidator,
    required this.modelValidator,
    required this.yearValidator,
    required this.plateNumberValidator,
    required this.odometerValidator,
    required this.onSelectPhoto,
    required this.onBack,
    required this.onSubmit,
    super.key,
  });

  final String appBarTitle;
  final String submitLabel;
  final IconData submitIcon;
  final GlobalKey<FormState> formKey;
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController plateNumberController;
  final TextEditingController odometerController;
  final TextEditingController nicknameController;
  final bool isLoading;
  final bool hasSelectedPhoto;
  final FormFieldValidator<String> brandValidator;
  final FormFieldValidator<String> modelValidator;
  final FormFieldValidator<String> yearValidator;
  final FormFieldValidator<String> plateNumberValidator;
  final FormFieldValidator<String> odometerValidator;
  final VoidCallback onSelectPhoto;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && !isLoading) onBack();
      },
      child: MDScaffold(
        appBarTitle: appBarTitle,
        appBarLeading: IconButton(
          tooltip: 'Back to Garage',
          onPressed: isLoading ? null : onBack,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PhotoUploadArea(
                      hasSelectedPhoto: hasSelectedPhoto,
                      enabled: !isLoading,
                      onTap: onSelectPhoto,
                    ),
                    const SizedBox(height: 24),
                    MDInputBox(
                      label: 'BRAND / MAKE',
                      controller: brandController,
                      hintText: 'e.g., Honda, Ducati',
                      enabled: !isLoading,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      validator: brandValidator,
                    ),
                    const SizedBox(height: 18),
                    MDInputBox(
                      label: 'MODEL',
                      controller: modelController,
                      hintText: 'e.g., CB650R, Monster',
                      enabled: !isLoading,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      validator: modelValidator,
                    ),
                    const SizedBox(height: 18),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final yearField = MDInputBox(
                          label: 'YEAR',
                          controller: yearController,
                          hintText: '2024',
                          enabled: !isLoading,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: yearValidator,
                        );
                        final plateField = MDInputBox(
                          label: 'PLATE NUMBER',
                          controller: plateNumberController,
                          hintText: 'IT-93-RED',
                          enabled: !isLoading,
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.next,
                          validator: plateNumberValidator,
                        );

                        if (constraints.maxWidth < 430) {
                          return Column(
                            children: [
                              yearField,
                              const SizedBox(height: 18),
                              plateField,
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: yearField),
                            const SizedBox(width: 16),
                            Expanded(child: plateField),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 18),
                    MDInputBox(
                      label: 'CURRENT ODOMETER (KM)',
                      controller: odometerController,
                      hintText: '0',
                      enabled: !isLoading,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: odometerValidator,
                    ),
                    const SizedBox(height: 18),
                    MDInputBox(
                      label: 'NICKNAME (OPTIONAL)',
                      controller: nicknameController,
                      hintText: 'My Beast',
                      enabled: !isLoading,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => onSubmit(),
                    ),
                    const SizedBox(height: 30),
                    MDButton(
                      label: submitLabel,
                      icon: submitIcon,
                      iconAtStart: true,
                      height: 56,
                      isLoading: isLoading,
                      onPressed: onSubmit,
                    ),
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

class _PhotoUploadArea extends StatelessWidget {
  const _PhotoUploadArea({
    required this.hasSelectedPhoto,
    required this.enabled,
    required this.onTap,
  });

  final bool hasSelectedPhoto;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _DashedBorderPainter(),
      child: Material(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(22),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: SizedBox(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasSelectedPhoto
                      ? Icons.check_circle_outline_rounded
                      : Icons.add_a_photo_outlined,
                  size: 58,
                  color: hasSelectedPhoto
                      ? AppColors.success
                      : AppColors.textSecondary,
                ),
                const SizedBox(height: 14),
                MDText(
                  hasSelectedPhoto
                      ? 'Bike Photo Selected'
                      : 'Upload Bike Photo',
                  variant: MDTextVariant.titleMedium,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 4),
                const MDText(
                  'JPG or PNG - Optional',
                  variant: MDTextVariant.bodySmall,
                  color: AppColors.neutral,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(22)),
      );
    final paint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 9), paint);
        distance += 15;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
