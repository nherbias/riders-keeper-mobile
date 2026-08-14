import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_button/md_button.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class MDMotorcycleCard extends StatelessWidget {
  const MDMotorcycleCard({
    required this.brand,
    required this.model,
    required this.plateNumber,
    required this.odometerKm,
    required this.onTap,
    this.imageAsset,
    this.isActive = false,
    this.onAddPhoto,
    super.key,
  });

  final String brand;
  final String model;
  final String plateNumber;
  final int odometerKm;
  final String? imageAsset;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onAddPhoto;

  @override
  Widget build(BuildContext context) {
    final semanticLabel =
        '$brand $model, ${isActive ? 'active, ' : ''}'
        '$plateNumber, ${_formatNumber(odometerKm)} kilometers';

    return Stack(
      children: [
        Semantics(
          button: true,
          label: semanticLabel,
          child: ExcludeSemantics(
            child: Material(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(22),
              clipBehavior: Clip.antiAlias,
              elevation: 1,
              shadowColor: Colors.black.withValues(alpha: .12),
              child: InkWell(
                onTap: onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 170,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          _MotorcycleVisual(imageAsset: imageAsset),
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Color(0x66000000)],
                                stops: [.55, 1],
                              ),
                            ),
                          ),
                          if (isActive)
                            Positioned(
                              right: 16,
                              top: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surface.withValues(
                                    alpha: .94,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: AppColors.success,
                                        shape: BoxShape.circle,
                                      ),
                                      child: SizedBox.square(dimension: 7),
                                    ),
                                    SizedBox(width: 7),
                                    MDText(
                                      'ACTIVE',
                                      variant: MDTextVariant.labelSmall,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 17, 20, 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MDText(
                                      brand.toUpperCase(),
                                      variant: MDTextVariant.labelMedium,
                                      color: AppColors.textSecondary,
                                      letterSpacing: 1.5,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    MDText(
                                      model,
                                      variant: MDTextVariant.title,
                                      fontWeight: FontWeight.w700,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const MDText(
                                            'Plate Number',
                                            variant: MDTextVariant.bodySmall,
                                            color: AppColors.textSecondary,
                                          ),
                                          MDText(
                                            plateNumber,
                                            variant: MDTextVariant.titleSmall,
                                            fontWeight: FontWeight.w800,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Icons.chevron_right_rounded,
                                      size: 21,
                                      color: AppColors.neutral,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.speed_outlined,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 10),
                                const MDText(
                                  'Odometer',
                                  variant: MDTextVariant.bodyMedium,
                                  color: AppColors.textSecondary,
                                ),
                                const Spacer(),
                                MDText(
                                  _formatNumber(odometerKm),
                                  variant: MDTextVariant.title,
                                  fontWeight: FontWeight.w800,
                                ),
                                const SizedBox(width: 5),
                                const MDText(
                                  'km',
                                  variant: MDTextVariant.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (onAddPhoto != null)
          Positioned(
            left: 18,
            top: 15,
            child: _AddPhotoButton(
              label: imageAsset == null ? 'ADD PHOTO' : 'CHANGE PHOTO',
              onPressed: onAddPhoto!,
            ),
          ),
      ],
    );
  }

  String _formatNumber(int value) {
    final digits = value.toString();
    return digits.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  }
}

class MDMotorcycleEmptyState extends StatelessWidget {
  const MDMotorcycleEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 34),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 112,
            height: 112,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.settings,
                  size: 88,
                  color: AppColors.surface.withValues(alpha: .08),
                ),
                const Icon(
                  Icons.two_wheeler,
                  size: 62,
                  color: AppColors.surface,
                ),
                const Positioned(
                  right: 5,
                  bottom: 8,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.surface,
                    child: Icon(
                      Icons.add_rounded,
                      size: 23,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const MDText(
            'Your garage is empty',
            variant: MDTextVariant.title,
            fontWeight: FontWeight.w800,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 7),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 310),
            child: const MDText(
              'Add your first motorcycle to track mileage, maintenance, and service history.',
              variant: MDTextVariant.bodyMedium,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.south_east_rounded, size: 16),
                SizedBox(width: 6),
                MDText(
                  'Tap Add Motorcycle to get started',
                  variant: MDTextVariant.labelSmall,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MDMotorcycleLoadingState extends StatelessWidget {
  const MDMotorcycleLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          SizedBox.square(
            dimension: 34,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 18),
          MDText(
            'Loading your garage',
            variant: MDTextVariant.titleMedium,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 4),
          MDText(
            'Getting your motorcycles ready.',
            variant: MDTextVariant.bodyMedium,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class MDMotorcycleErrorState extends StatelessWidget {
  const MDMotorcycleErrorState({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 34,
            backgroundColor: AppColors.secondary,
            child: Icon(
              Icons.cloud_off_outlined,
              size: 34,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 18),
          const MDText(
            'Unable to load your garage',
            variant: MDTextVariant.titleMedium,
            fontWeight: FontWeight.w800,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          MDText(
            message,
            variant: MDTextVariant.bodyMedium,
            color: AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          MDButton(
            label: 'TRY AGAIN',
            icon: Icons.refresh_rounded,
            iconAtStart: true,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}

class _MotorcycleVisual extends StatelessWidget {
  const _MotorcycleVisual({required this.imageAsset});

  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    if (imageAsset != null) {
      return Image.asset(
        imageAsset!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const _MotorcycleFallback(),
      );
    }
    return const _MotorcycleFallback();
  }
}

class _MotorcycleFallback extends StatelessWidget {
  const _MotorcycleFallback();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -.25),
          radius: 1.15,
          colors: [Color(0xFF56616A), Color(0xFF282D32), Color(0xFF151719)],
          stops: [0, .55, 1],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(right: -58, top: -82, child: _PlaceholderRing()),
          Positioned(
            left: -72,
            bottom: -112,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0x0AFFFFFF), width: 24),
                ),
              ),
              child: SizedBox(width: 240, height: 240),
            ),
          ),
          Positioned(
            left: 28,
            right: 28,
            bottom: 21,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0x40000000),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.elliptical(100, 12)),
              ),
              child: SizedBox(height: 16),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(0, 4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0x1FFFFFFF), Color(0x08FFFFFF)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  border: Border.fromBorderSide(
                    BorderSide(color: Color(0x26FFFFFF)),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4D000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 148,
                  height: 104,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.two_wheeler_rounded,
                        size: 72,
                        color: AppColors.surface,
                      ),
                      SizedBox(height: 1),
                      MDText(
                        'MOTORCYCLE',
                        variant: MDTextVariant.labelSmall,
                        color: Color(0xBFFFFFFF),
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPhotoButton extends StatelessWidget {
  const _AddPhotoButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Add motorcycle photo',
      child: Material(
        color: const Color(0xB3212326),
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add_a_photo_outlined,
                  size: 14,
                  color: AppColors.surface,
                ),
                const SizedBox(width: 6),
                MDText(
                  label,
                  variant: MDTextVariant.labelSmall,
                  color: AppColors.surface,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderRing extends StatelessWidget {
  const _PlaceholderRing();

  @override
  Widget build(BuildContext context) => Container(
    width: 230,
    height: 230,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: const Color(0x0FFFFFFF), width: 30),
    ),
  );
}
