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
                WlthyText(
                  Pricing.subtitle,
                  style: FigmaText.pricingSubtitle(const Color(0xFFF5F5F5)),
                ),
                const SizedBox(height: 12),
                WlthyText(
                  Pricing.body,
                  style: FigmaText.cardBody(AppColors.onDarkMuted),
                ),
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
    // Desktop: three equal-height cards. We deliberately do NOT use
    // IntrinsicHeight here: its height is an *estimate* that, on Flutter web,
    // comes out ~1 line short for the tallest card when google_fonts' serif is
    // still loading during the intrinsic pass (fallback glyphs wrap to fewer
    // lines), which then clips the real layout. Instead [_EqualHeightCards]
    // measures each card's actual laid-out height and levels them via a
    // minHeight — a card can never be constrained shorter than its content.
    return _EqualHeightCards(tiers, gap: _gap);
  }
}

/// Lays out [tiers] as a fixed-width row and levels every card to the tallest
/// card's *measured* height (re-measured on width change and once the real
/// fonts finish loading), so no card is ever clipped.
class _EqualHeightCards extends StatefulWidget {
  const _EqualHeightCards(this.tiers, {required this.gap});

  final List<PricingTier> tiers;
  final double gap;

  @override
  State<_EqualHeightCards> createState() => _EqualHeightCardsState();
}

class _EqualHeightCardsState extends State<_EqualHeightCards> {
  List<GlobalKey> _keys = const [];
  double? _height;

  void _remeasure() {
    if (!mounted) return;
    var tallest = 0.0;
    for (final key in _keys) {
      final box = key.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) return; // not laid out yet — bail
      if (box.size.height > tallest) tallest = box.size.height;
    }
    if (tallest > 0 && (_height == null || (tallest - _height!).abs() > 0.5)) {
      setState(() => _height = tallest);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_keys.length != widget.tiers.length) {
      _keys = List.generate(widget.tiers.length, (_) => GlobalKey());
    }
    // After every layout, reconcile the levelled height with what the cards
    // actually measured. Cheap, and only calls setState when it changes, so it
    // settles in one extra frame (and re-settles when fonts load / width shifts)
    // without looping.
    WidgetsBinding.instance.addPostFrameCallback((_) => _remeasure());

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardW =
            (constraints.maxWidth - widget.gap * (widget.tiers.length - 1)) /
            widget.tiers.length;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < widget.tiers.length; i++) ...[
              if (i > 0) SizedBox(width: widget.gap),
              SizedBox(
                width: cardW,
                child: _TierCard(
                  widget.tiers[i],
                  minHeight: _height,
                  contentKey: _keys[i],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _TierCard extends StatelessWidget {
  const _TierCard(this.tier, {this.minHeight, this.contentKey});
  final PricingTier tier;

  /// When set, the card fills to at least this height (used to level a row of
  /// cards) without ever constraining its content shorter than its natural
  /// size — so it cannot clip regardless of how the height was derived.
  final double? minHeight;

  /// Attached to the content (not the fill), so a caller measuring it always
  /// reads the card's *natural* content height even when [minHeight] pads it.
  final Key? contentKey;

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
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      child: Stack(
        children: [
          // Fill stretches to the levelled card height…
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: _fill,
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          // …while the content keeps its natural height, pinned to the top.
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              key: contentKey,
              padding: const EdgeInsets.all(20),
              child: _content(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        WlthyText(
          tier.tagline.toUpperCase(),
          style: FigmaText.eyebrow(const Color(0xFFF5F5F5)),
        ),
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
          child: WlthyText(
            'Price: ${tier.price}',
            style: FigmaText.tierPrice(AppColors.white),
          ),
        ),
        const SizedBox(height: 14),
        WlthyText(
          tier.description,
          style: FigmaText.tierDescription(AppColors.onDarkMuted),
        ),
        const SizedBox(height: 16),
        WlthyText(
          'Includes:',
          style: FigmaText.tierDescription(AppColors.onDark),
        ),
        const SizedBox(height: 4),
        for (final f in tier.includes)
          Padding(padding: const EdgeInsets.only(bottom: 2), child: _bullet(f)),
        const SizedBox(height: 20),
        Align(alignment: Alignment.centerLeft, child: _PricingButton(tier.cta)),
      ],
    );
  }

  /// One "Includes:" list item. Rendered as a single [Text.rich] paragraph
  /// (bullet glyph + label) rather than a Row/Expanded — nested flex children
  /// mis-measure under IntrinsicHeight, which under-sizes the tallest card and
  /// causes a bottom overflow. A single paragraph measures accurately.
  Widget _bullet(String label) {
    final style = FigmaText.tierBullet(AppColors.onDark);
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: '• '),
            ...wlthySpans(label, style),
          ],
        ),
        style: style,
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
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
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
