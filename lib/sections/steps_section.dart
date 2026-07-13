import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/wlthy_text.dart';

/// "Four steps to your full picture" (Figma 213:278, 1510×350): white band,
/// narrow title block on the left, the four steps in ONE row separated by
/// vertical dividers, and the person-holding-phone cutout anchored to the
/// band's top/right/bottom so its hard photo edges coincide with the band
/// edges. Mobile (Figma 217:833) stacks the steps and puts the photo below.
class StepsSection extends StatelessWidget {
  const StepsSection({super.key});

  static const _divider = Color(0xFFE0E0E0);

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return _mobile(context);
    return _desktop(context);
  }

  Widget _desktop(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Stack(
        children: [
          // Photo pinned to the band's top/right/bottom — its hard top and
          // right edges align with the band edges, as in the Figma fill crop.
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Image.asset(
              AppImages.screen2,
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerRight,
              filterQuality: FilterQuality.high,
            ),
          ),
          Center(
            // Figma content grid for this band starts at x≈126 of 1510 —
            // wider than the standard 1000 column.
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1256),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.gutter, vertical: 58),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 200, child: _title(context)),
                    for (var i = 0; i < Steps.items.length; i++)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          decoration: i > 0
                              ? const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: _divider),
                                  ),
                                )
                              : null,
                          child: _Step(Steps.items[i]),
                        ),
                      ),
                    // Breathing room so the last column clears the photo.
                    const SizedBox(width: 220),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobile(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(context.gutter, 40, context.gutter, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(context),
                const SizedBox(height: 24),
                for (final s in Steps.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: _Step(s),
                  ),
              ],
            ),
          ),
          // Photo below the steps, right-anchored (Figma 217:833 bottom area).
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              AppImages.screen2,
              height: 340,
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerRight,
              filterQuality: FilterQuality.high,
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText('SIMPLE BY DESIGN',
              style: FigmaText.eyebrow(AppColors.inkMuted)),
          const SizedBox(height: 10),
          WlthyText(Steps.title, style: FigmaText.h2(AppColors.ink)),
        ],
      );
}

class _Step extends StatelessWidget {
  const _Step(this.step);
  final StepItem step;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        WlthyText(step.number, style: FigmaText.stepNumber(AppColors.accentInk)),
        const SizedBox(height: 6),
        WlthyText(step.title, style: FigmaText.cardTitleSerif(AppColors.ink)),
        const SizedBox(height: 8),
        WlthyText(step.body,
            style: FigmaText.cardBody(const Color(0xFF5C5C58))),
      ],
    );
  }
}
