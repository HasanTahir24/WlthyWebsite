import 'package:flutter/material.dart';

import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      gradient: AppColors.pricingBand,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 490),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  eyebrow: Pricing.eyebrow,
                  title: Pricing.title,
                  onDark: true,
                ),
                const SizedBox(height: 18),
                WlthyText(Pricing.subtitle,
                    style: FigmaText.pricingSubtitle(AppColors.onDark)),
                const SizedBox(height: 12),
                WlthyText(Pricing.body,
                    style: FigmaText.cardBody(AppColors.onDarkMuted)),
              ],
            ),
          ),
          const SizedBox(height: 48),
          ResponsiveGrid(
            desktopColumns: 3,
            tabletColumns: 1,
            mobileColumns: 1,
            spacing: 24,
            runSpacing: 24,
            children: [for (final t in Pricing.tiers) _TierCard(t)],
          ),
        ],
      ),
    );
  }
}

class _TierCard extends StatelessWidget {
  const _TierCard(this.tier);
  final PricingTier tier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.cardOnDark,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: tier.highlighted
              ? AppColors.accent
              : AppColors.hairlineOnDark,
          width: tier.highlighted ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WlthyText(tier.tagline.toUpperCase(),
              style: FigmaText.eyebrow(AppColors.onDarkMuted)),
          const SizedBox(height: 12),
          WlthyText(tier.name, style: FigmaText.tierName(AppColors.onDark)),
          const SizedBox(height: 8),
          WlthyText(tier.price, style: FigmaText.tierPrice(AppColors.accentSoft)),
          const SizedBox(height: 16),
          WlthyText(tier.description,
              style: FigmaText.cardBody(AppColors.onDarkMuted)),
          const SizedBox(height: 20),
          for (final f in tier.includes)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check,
                      size: 16, color: AppColors.accentSoft),
                  const SizedBox(width: 10),
                  Expanded(
                    child: WlthyText(f,
                        style: FigmaText.cardBody(AppColors.onDark)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: _PricingButton(tier.cta),
          ),
        ],
      ),
    );
  }
}

/// Small left-aligned outline CTA used on every pricing card (Figma: fill=-,
/// r=6, ~36px tall, white w400 14 label).
class _PricingButton extends StatelessWidget {
  const _PricingButton(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.28)),
        ),
        child: WlthyText(label, style: FigmaText.tierButton(AppColors.white)),
      ),
    );
  }
}
