import 'package:flutter/material.dart';
import 'package:riders_keeper/core/constants/theme/app_colors.dart';
import 'package:riders_keeper/core/design_system/atoms/md_text/md_text.dart';
import 'package:riders_keeper/core/design_system/molecules/md_motorcycle_card/md_motorcycle_card.dart';
import 'package:riders_keeper/core/enum/text_variant.dart';

class MDMotorcycleHeroPlaceholder extends StatelessWidget {
  const MDMotorcycleHeroPlaceholder({
    required this.brand,
    required this.model,
    required this.plateNumber,
    required this.odometerKm,
    this.badgeLabel,
    this.title,
    this.height = 210,
    super.key,
  });

  final String brand;
  final String model;
  final String plateNumber;
  final int odometerKm;
  final String? badgeLabel;
  final String? title;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = height / 170;
        return SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ExcludeSemantics(
                    child: IgnorePointer(
                      child: Transform.scale(
                        scale: scale,
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: constraints.maxWidth,
                          child: MDMotorcycleCard(
                            brand: brand,
                            model: model,
                            plateNumber: plateNumber,
                            odometerKm: odometerKm,
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (badgeLabel != null)
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: .9),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: MDText(
                        badgeLabel!,
                        variant: MDTextVariant.labelSmall,
                        color: AppColors.surface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .8,
                      ),
                    ),
                  ),
                if (title != null)
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 16,
                    child: MDText(
                      title!,
                      variant: MDTextVariant.title,
                      color: AppColors.surface,
                      fontWeight: FontWeight.w800,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
