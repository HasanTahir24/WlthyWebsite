import 'package:flutter/material.dart';

import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// "wlthy is not" — a row of boundary chips.
class BoundariesSection extends StatelessWidget {
  const BoundariesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      background: AppColors.sand,
      child: Column(
        children: [
          SectionHeader(
              eyebrow: Boundaries.eyebrow,
              title: Boundaries.title,
              center: true),
          const SizedBox(height: 32),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
              for (final chip in Boundaries.chips)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: WlthyText(chip, style: FigmaText.chip(AppColors.ink)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: WlthyText(
              Boundaries.footnote,
              textAlign: TextAlign.center,
              style: FigmaText.footnoteSerif(AppColors.ink),
            ),
          ),
        ],
      ),
    );
  }
}
