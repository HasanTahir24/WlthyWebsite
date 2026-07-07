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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WlthyText(item.title, style: FigmaText.cardTitleSerif(AppColors.ink)),
          const SizedBox(height: 10),
          WlthyText(item.body,
              style: FigmaText.cardBody(const Color(0xFF5C5C58))),
        ],
      ),
    );
  }
}
