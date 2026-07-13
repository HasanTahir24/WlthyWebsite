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

  // Figma 213:278 (1510×350): content column starts at x=126 (title + 4
  // steps, 1003 wide, top-padded 40), leaving 381px on the right where the
  // person-holding-phone cutout is pinned flush to the band's top/right/
  // bottom edges. No Stack/Positioned — a fixed-height Row keeps the photo
  // column from ever overlapping the text as the window is resized.
  Widget _desktop(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: 350,
        child: ColoredBox(
          color: AppColors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 126, top: 40),
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 381,
                height: 350,
                child: Image.asset(
                  AppImages.screen2,
                  fit: BoxFit.cover,
                  alignment: Alignment.topRight,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
        ),
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
            style: FigmaText.cardBody(const Color(0xFF5C5C58)),maxLines: 3, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
