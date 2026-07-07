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
      gradient: AppColors.audienceBand,
      verticalPadding: 44,
      child: context.isMobile
          ? Column(
              children: [
                for (final c in Audience.cards)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _Card(c),
                  ),
              ],
            )
          // Equal width via Expanded; height is unconstrained (min 180) so the
          // card grows to fit its text — overflow is structurally impossible.
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < Audience.cards.length; i++) ...[
                  if (i > 0) const SizedBox(width: 11),
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
    return Container(
      constraints: const BoxConstraints(minHeight: 180),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.white.withValues(alpha: 0.10),
            AppColors.white.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(item.label.toUpperCase(),
              style: FigmaText.eyebrow(AppColors.accentSoft)),
          const SizedBox(height: 10),
          WlthyText(item.title, style: FigmaText.cardTitleSerif(AppColors.onDark)),
          const SizedBox(height: 8),
          WlthyText(item.body, style: FigmaText.cardBody(AppColors.onDarkMuted)),
        ],
      ),
    );
  }
}
