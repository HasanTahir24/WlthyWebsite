import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// "Who wlthy is built for" (Figma 213:357): four white cards over a soft
/// botanical shadow background.
class BuiltForSection extends StatelessWidget {
  const BuiltForSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      image: const DecorationImage(
        image: AssetImage(AppImages.builtForBg),
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            eyebrow: BuiltFor.eyebrow,
            title: BuiltFor.title,
            eyebrowColor: AppColors.taupe,
            center: true,
          ),
          const SizedBox(height: 32),
          ResponsiveGrid(
            desktopColumns: 4,
            tabletColumns: 2,
            mobileColumns: 1,
            children: [for (final c in BuiltFor.cards) _Card(c)],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.item);
  final FeatureItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.hairline),
      ),
      // OverflowBox lets content take natural height so the fixed-height card
      // clips gracefully instead of asserting (fallback fonts render taller).
      child: OverflowBox(
        alignment: Alignment.topLeft,
        maxHeight: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              WlthyText(item.title,
                  style: FigmaText.cardTitleSerif(AppColors.ink)),
              const SizedBox(height: 10),
              WlthyText(item.body,
                  style: FigmaText.cardBody(const Color(0xFF5C5C58))),
            ],
          ),
        ),
      ),
    );
  }
}
