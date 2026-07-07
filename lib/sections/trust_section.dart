import 'package:flutter/material.dart';

import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// "Built around what money tools should never do" (Figma 213:383): six plain
/// text blocks (bold title + body), no icons, over the botanical background.
class TrustSection extends StatelessWidget {
  const TrustSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      background: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            eyebrow: Trust.eyebrow,
            title: Trust.title,
            eyebrowColor: AppColors.accentInk,
          ),
          const SizedBox(height: 36),
          ResponsiveGrid(
            desktopColumns: 6,
            tabletColumns: 3,
            mobileColumns: 2,
            spacing: 16,
            runSpacing: 32,
            children: [for (final i in Trust.items) _Item(i)],
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.item);
  final FeatureItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        WlthyText(item.title, style: FigmaText.trustItemTitle(AppColors.ink)),
        const SizedBox(height: 8),
        WlthyText(item.body,
            style: FigmaText.cardBody(const Color(0xFF5C5C58))),
      ],
    );
  }
}
