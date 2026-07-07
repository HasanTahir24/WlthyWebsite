import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/wlthy_button.dart';
import '../widgets/wlthy_text.dart';

/// Full-bleed brand banner built around [AppImages.phoneBanner] — the wide
/// "hands holding a phone" shot with open space on the left, where the copy and
/// CTA are overlaid. A left-side scrim keeps text legible when the image is
/// cropped on narrow screens.
class PhoneBannerSection extends StatelessWidget {
  const PhoneBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.responsive<double>(
      mobile: 360,
      tablet: 420,
      desktop: 480,
    );

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.phoneBanner,
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
            filterQuality: FilterQuality.high,
          ),
          // Left scrim matched to the image's own grey (#D7D7D7) so it blends
          // with the boundaries band above instead of lightening the left.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 0.5, 0.75],
                colors: [
                  Color(0xFFD7D7D7),
                  Color(0xCCD7D7D7),
                  Color(0x00D7D7D7),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.gutter),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Copy + CTA on the left.
                    Expanded(
                      flex: 6,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 460),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Eyebrow(ComingSoon.eyebrow),
                            const SizedBox(height: 14),
                            WlthyText(
                              ComingSoon.title,
                              style: FigmaText.h2(AppColors.ink),
                            ),
                            const SizedBox(height: 14),
                            WlthyText(
                              ComingSoon.body,
                              style: FigmaText.comingSoonBody(const Color(0xFF5C5C58)),
                            ),
                            const SizedBox(height: 22),
                            WlthyButton(ComingSoon.cta),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    // "in development" status pills stacked on the right.
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final s in ComingSoon.statuses)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _StatusPill(s),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Outlined "— in development" status pill (Figma: fill=-, r=8, ~34px).
class _StatusPill extends StatelessWidget {
  const _StatusPill(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.ink.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.taupe,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          WlthyText(label, style: FigmaText.statusPill(const Color(0xFF5C5C58))),
        ],
      ),
    );
  }
}
