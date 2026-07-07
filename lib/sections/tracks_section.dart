import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/app_assets.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// Warm taupe→brown band, "Six things wlthy tracks for you" (Figma 213:220):
/// a centred title over a 3-column grid of centred, white items.
class TracksSection extends StatelessWidget {
  const TracksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      gradient: AppColors.taupeBand,
      child: Column(
        children: [
          SectionHeader(title: Tracks.title, center: true, onDark: true),
          const SizedBox(height: 48),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: ResponsiveGrid(
                desktopColumns: 3,
                tabletColumns: 2,
                mobileColumns: 1,
                spacing: 24,
                runSpacing: 44,
                children: [
                  for (var i = 0; i < Tracks.items.length; i++)
                    _Track(Tracks.items[i], AppImages.trackIcons[i]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Track extends StatelessWidget {
  const _Track(this.item, this.iconAsset);
  final FeatureItem item;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(iconAsset, width: 30, height: 30),
        const SizedBox(height: 14),
        WlthyText(item.title,
            textAlign: TextAlign.center,
            style: FigmaText.cardTitleSerif(AppColors.white)),
        const SizedBox(height: 8),
        WlthyText(item.body,
            textAlign: TextAlign.center,
            style: FigmaText.cardBody(AppColors.white)),
      ],
    );
  }
}
