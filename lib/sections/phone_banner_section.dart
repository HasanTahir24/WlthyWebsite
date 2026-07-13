import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/wlthy_text.dart';

/// "Coming soon on iOS & Android" (Figma 213:490, 1510×345): copy + black CTA
/// on the left, the two status pills stacked in the upper-middle-right
/// (x≈903), and the Freedom-Plan phone anchored top-right, cropped by the
/// band's bottom edge.
class PhoneBannerSection extends StatelessWidget {
  const PhoneBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return _mobile(context);
    return _desktop(context);
  }

  Widget _desktop(BuildContext context) {
    return ClipRect(
      child: Container(
        color: AppColors.white,
        height: 345,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.gutter),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Copy + CTA (Figma column x=255..856).
                    Positioned(
                      left: 0,
                      top: 40,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 601),
                        child: _copy(context),
                      ),
                    ),
                    // Status pills at x≈648 within the column, y≈91.
                    Positioned(
                      left: 648,
                      top: 91,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _StatusPill('iOS — in development', Icons.apple),
                          const SizedBox(height: 9),
                          _StatusPill(
                              'Android — in development', Icons.android),
                        ],
                      ),
                    ),
                    // Phone: top-anchored right, taller than the band — its
                    // bottom is cropped by the band edge (ClipRect above).
                    Positioned(
                      right: -150,
                      top: 40,
                      child: Image.asset(
                        AppImages.screen3,
                        width: 280,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                        filterQuality: FilterQuality.high,
                      ),
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

  Widget _mobile(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(context.gutter, 40, context.gutter, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _copy(context),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    _StatusPill('iOS — in development', Icons.apple),
                    _StatusPill('Android — in development', Icons.android),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Phone cropped at the band bottom, right-aligned.
          ClipRect(
            child: Align(
              alignment: Alignment.topRight,
              heightFactor: 0.75,
              child: Padding(
                padding: EdgeInsets.only(right: context.gutter),
                child: Image.asset(
                  AppImages.screen3,
                  width: 300,
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _copy(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(ComingSoon.eyebrow.toUpperCase(),
              style: FigmaText.eyebrow(AppColors.ink)),
          const SizedBox(height: 5),
          WlthyText(ComingSoon.title, style: FigmaText.h2(AppColors.ink)),
          const SizedBox(height: 10),
          WlthyText(ComingSoon.body,
              style: FigmaText.comingSoonBody(const Color(0xFF5C5C58))),
          const SizedBox(height: 16),
          _blackButton(ComingSoon.cta),
        ],
      );

  Widget _blackButton(String label) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 37,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A18),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.center,
            widthFactor: 1,
            child: WlthyText(label, style: FigmaText.button(AppColors.white)),
          ),
        ),
      );
}

/// Outlined status pill (Figma: 34 tall, r=8, 1px light border, glyph +
/// Inter 11/18 #5C5C58 label).
class _StatusPill extends StatelessWidget {
  const _StatusPill(this.label, this.icon);
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0x26000000)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF5C5C58)),
          const SizedBox(width: 7),
          WlthyText(label, style: FigmaText.statusPill(const Color(0xFF5C5C58))),
        ],
      ),
    );
  }
}
