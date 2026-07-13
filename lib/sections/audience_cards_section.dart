import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// The four glassy cards on the dark band under the hero (Figma 213:124).
/// Each card: blue label, serif headline, body paragraph.
class AudienceCardsSection extends StatelessWidget {
  const AudienceCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      maxWidth: double.infinity,
      gradient: AppColors.audienceBand,
      verticalPadding: 44,
      child: context.isMobile
          ? SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 0),
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              child: Row(
                children: [
                  for (var i = 0; i < Audience.cards.length; i++) ...[
                    if (i > 0) const SizedBox(width: 10),
                    SizedBox(width: 242.5, child: _Card(Audience.cards[i])),
                  ],
                ],
              ),
            ),
          )
          // Four equal-width cards, all a fixed 180px tall (Figma 242×180).
          : Row(
              children: [
                for (var i = 0; i < Audience.cards.length; i++) ...[
                  if (i > 0) const SizedBox(width: 10),
                  Expanded(child: _Card(Audience.cards[i])),
                ],
              ],
            ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.item);
  final AudienceCard item;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(item.label.toUpperCase(),
              style: FigmaText.eyebrow(AppColors.hairline)),
          const SizedBox(height: 8),
          WlthyText(item.title, style: FigmaText.cardTitleSerif(AppColors.onDark)),
          const SizedBox(height: 6),
          WlthyText(item.body,
              style: FigmaText.cardBody(AppColors.onDark)
                  ),
        ],
      ),
    );

    return Container(
      height:  180,
      constraints:
           null,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
      ),
      // OverflowBox lets the content take its natural height (top-aligned) so
      // the fixed-height card never throws an overflow assertion — the card
      // simply clips anything beyond 180 (the real fonts fit within 180).
      child:  OverflowBox(
              alignment: Alignment.topLeft,
              maxHeight: double.infinity,
              child: content,
            ),
    );
  }
}
