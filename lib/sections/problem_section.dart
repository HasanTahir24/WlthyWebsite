import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// "The problem" band (Figma 213:185, 1510×323): taupe eyebrow + heading on
/// the left (411 wide), three identical full-width cards (491×68, white @30%,
/// r=8) stacked on the right with 10px gaps.
class ProblemSection extends StatelessWidget {
  const ProblemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      gradient: AppColors.problemBand,
      child: ResponsiveLayout(
        mobile: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(),
            const SizedBox(height: 28),
            ..._cards(),
          ],
        ),
        desktop: (_) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 411),
                child: _header(),
              ),
            ),
            const SizedBox(width: 100),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _cards(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() => SectionHeader(
        eyebrow: Problem.eyebrow,
        title: Problem.title,
        body: Problem.body,
        eyebrowColor: AppColors.taupe,
        bodyStyle: FigmaText.problemBody,
      );

  List<Widget> _cards() => [
        for (var i = 0; i < Problem.points.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          _Card(Problem.points[i]),
        ],
      ];
}

class _Card extends StatelessWidget {
  const _Card(this.item);
  final FeatureItem item;

  @override
  Widget build(BuildContext context) {
    // Figma: 491×68, white @30%, r=8, 14px padding, 4px title→body gap.
    return Container(
      constraints: const BoxConstraints(minHeight: 68),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(item.title, style: FigmaText.cardTitleSerif(AppColors.ink)),
          const SizedBox(height: 4),
          WlthyText(item.body,
              style: FigmaText.cardBodySmall(const Color(0xFF5C5C58))),
        ],
      ),
    );
  }
}
