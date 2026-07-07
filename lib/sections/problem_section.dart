import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

class ProblemSection extends StatelessWidget {
  const ProblemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      gradient: AppColors.problemBand,
      child: ResponsiveLayout(
        mobile: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
                eyebrow: Problem.eyebrow,
                title: Problem.title,
                body: Problem.body,
                bodyStyle: FigmaText.problemBody),
            const SizedBox(height: 32),
            ..._points(context),
          ],
        ),
        desktop: (_) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SectionHeader(
                  eyebrow: Problem.eyebrow,
                  title: Problem.title,
                  body: Problem.body,
                  bodyStyle: FigmaText.problemBody),
            ),
            const SizedBox(width: 64),
            Expanded(
              flex: 5,
              child: Column(children: _points(context)),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _points(BuildContext context) => [
        for (final p in Problem.points)
          Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.hairline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WlthyText(p.title, style: FigmaText.cardTitleSerif(AppColors.ink)),
                const SizedBox(height: 8),
                WlthyText(p.body, style: FigmaText.cardBodySmall(const Color(0xFF5C5C58))),
              ],
            ),
          ),
      ];
}
