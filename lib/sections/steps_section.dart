import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// "Four steps to your full picture" (Figma 213:278). The hand-holding-phone
/// shot is the full-bleed background (phone on the right); the title and the
/// four numbered steps sit over the open left side.
class StepsSection extends StatelessWidget {
  const StepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return SectionBand(
        background: AppColors.sand,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(context),
            const SizedBox(height: 28),
            for (final s in Steps.items)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _Step(s),
              ),
          ],
        ),
      );
    }

    return SectionBand(
      image: const DecorationImage(
        image: AssetImage(AppImages.stepsBg),
        fit: BoxFit.cover,
        alignment: Alignment.centerRight,
      ),
      foregroundOverlay: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 0.5, 0.78],
            colors: [Color(0xFFD7D7D7), Color(0xCCD7D7D7), Color(0x00D7D7D7)],
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 170, child: _title(context)),
            const SizedBox(width: 40),
            for (var i = 0; i < Steps.items.length; i++) ...[
              if (i > 0) const SizedBox(width: 22),
              SizedBox(width: 150, child: _Step(Steps.items[i])),
            ],
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Eyebrow(Steps.eyebrow),
          const SizedBox(height: 14),
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
        const SizedBox(height: 12),
        WlthyText(step.title, style: FigmaText.cardTitleSerif(AppColors.ink)),
        const SizedBox(height: 8),
        WlthyText(step.body,
            style: FigmaText.cardBody(const Color(0xFF5C5C58))),
      ],
    );
  }
}
