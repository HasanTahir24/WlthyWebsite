import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// Pricing band (Figma 213:419, 1510×860): intro copy on the left, then three
/// equal-height tier cards. Each card is a soft top-lit gradient panel (no
/// border — the middle tier is NOT highlighted in the design), with a
/// "Price:" row fenced by thin taupe rules and a bulleted "Includes:" list.
class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  static const _gap = 24.0;

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
                  eyebrowColor: AppColors.white,
                ),
                const SizedBox(height: 18),
                WlthyText(Pricing.subtitle,
                    style: FigmaText.pricingSubtitle(const Color(0xFFF5F5F5))),
                const SizedBox(height: 12),
                WlthyText(Pricing.body,
                    style: FigmaText.cardBody(AppColors.onDarkMuted)),
              ],
            ),
          ),
          const SizedBox(height: 48),
          _cards(context),
        ],
      ),
    );
  }

  Widget _cards(BuildContext context) {
    final tiers = Pricing.tiers;
    // Tablet/mobile: single stacked column (each card sizes to its content).
    if (!context.isDesktop) {
      return Column(
        children: [
          for (var i = 0; i < tiers.length; i++) ...[
            if (i > 0) const SizedBox(height: _gap),
            _TierCard(tiers[i]),
          ],
        ],
      );
    }
    // Desktop: three equal-height cards. Widths are fixed here (not via
    // Expanded) so IntrinsicHeight measures each card at its real width and
    // CrossAxisAlignment.stretch levels every card to the tallest one.
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardW = (constraints.maxWidth - _gap * (tiers.length - 1)) /
            tiers.length;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < tiers.length; i++) ...[
                if (i > 0) const SizedBox(width: _gap),
                SizedBox(width: cardW, child: _TierCard(tiers[i])),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _TierCard extends StatelessWidget {
  const _TierCard(this.tier);
  final PricingTier tier;

  // Card fill: a top-lit #1E1E1E gradient fading to transparent (Figma:
  // 50% → 0% top to bottom). No stroke.
  static const _fill = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x801E1E1E), Color(0x001E1E1E)],
  );

  // Thin rules that fence the price row.
  static const _priceRule = Color(0xFFA58A6A);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: _fill,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(tier.tagline.toUpperCase(),
              style: FigmaText.eyebrow(const Color(0xFFF5F5F5))),
          const SizedBox(height: 14),
          _tierName(tier.name),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: _priceRule, width: 0.5),
                bottom: BorderSide(color: _priceRule, width: 0.5),
              ),
            ),
            child: WlthyText('Price: ${tier.price}',
                style: FigmaText.tierPrice(AppColors.white)),
          ),
          const SizedBox(height: 14),
          WlthyText(tier.description,
              style: FigmaText.tierDescription(AppColors.onDarkMuted)),
          const SizedBox(height: 16),
          WlthyText('Includes:',
              style: FigmaText.tierDescription(AppColors.onDark)),
          const SizedBox(height: 4),
          for (final f in tier.includes)
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 8),
                    child: WlthyText('•',
                        style: FigmaText.tierBullet(AppColors.onDark)),
                  ),
                  Expanded(
                    child: WlthyText(f,
                        style: FigmaText.tierBullet(AppColors.onDark)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: _PricingButton(tier.cta),
          ),
        ],
      ),
    );
  }

  /// "wlthy start" → "wlthy" (regular) + plan word (bold), matching Figma —
  /// the reverse of the usual [WlthyText] brand treatment.
  Widget _tierName(String name) {
    final space = name.indexOf(' ');
    final brand = space == -1 ? name : name.substring(0, space);
    final plan = space == -1 ? '' : name.substring(space);
    final base = FigmaText.tierName(AppColors.white);
    return Text.rich(
      TextSpan(
        style: base,
        children: [
          TextSpan(text: brand),
          TextSpan(
              text: plan,
              style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

/// Small left-aligned outline CTA used on every pricing card (Figma: fill=-,
/// r=6, ~36px tall, white 1px border, white w400 14 label).
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
          border: Border.all(color: AppColors.white.withValues(alpha: 0.9)),
        ),
        child: WlthyText(label, style: FigmaText.tierButton(AppColors.white)),
      ),
    );
  }
}
