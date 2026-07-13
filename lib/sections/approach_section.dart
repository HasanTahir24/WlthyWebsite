import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// Quiet centred statement band (Figma 213:210, 1510×380): black eyebrow, a
/// one-line light taupe headline, a centred serif paragraph, and a 2px taupe
/// vertical line running down toward the next band.
class ApproachSection extends StatelessWidget {
  const ApproachSection({super.key});

  @override
  Widget build(BuildContext context) {
    final titleSize = context.responsive<double>(mobile: 28, desktop: 36);
    return SectionBand(
      background: AppColors.cream,
      // The taupe line runs to the band's bottom edge (no bottom padding).
      verticalPadding: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WlthyText(
                Approach.eyebrow.toUpperCase(),
                textAlign: TextAlign.center,
                boldWeight: FontWeight.w800,
                style: FigmaText.eyebrow(const Color(0xFF000000)),
              ),
              const SizedBox(height: 18),
              WlthyText(
                Approach.title,
                textAlign: TextAlign.center,
                boldWeight: FontWeight.w500,
                style: AppType.sans(TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w300,
                  height: 32 / 36, // exact Figma ratio (36px / 32px line height)
                  color: AppColors.taupe,
                )),
              ),
              const SizedBox(height: 24),
              // Body box is 582px in the file.
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 582),
                child: WlthyText(
                  Approach.body,
                  textAlign: TextAlign.center,
                  style: FigmaText.approachBody(const Color(0xFF5C5C58)),
                ),
              ),
              const SizedBox(height: 40),
              // Figma "Line 26": 2px taupe vertical line, ~140 tall, centred.
              Container(width: 2, height: context.isMobile ? 70: 140, color: AppColors.taupe),
            ],
          ),
        ),
      ),
    );
  }
}
