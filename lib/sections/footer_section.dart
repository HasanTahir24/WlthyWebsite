import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/responsive.dart';
import '../core/scroll_registry.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/wlthy_text.dart';

/// Maps each footer link to the section it scrolls to, mirroring the nav bar.
/// The Legal column has no matching band on the page, so those links are
/// absent here and render as plain, non-interactive text.
final Map<String, GlobalKey> _footerTargets = {
  'How it works': SectionKeys.howItWorks,
  'Features': SectionKeys.features,
  'The wlthy Method': SectionKeys.method,
  'Join the waitlist': SectionKeys.waitlist,
  'About': SectionKeys.company,
  'Trust': SectionKeys.trust,
  'Contact': SectionKeys.company,
};

/// Footer (Figma 213:614, 1510×430, #251B10): a square wlthy logo with tagline
/// on the left, then three link columns (Product, Company, Legal). No divider
/// or copyright line in the file. Content starts at a 48px gutter.
///
/// Mobile (Figma 217:1085, 398×413) reorders this: the three link columns
/// come first in a plain Row (natural, unequal widths — "Product" is wider
/// than "Company"/"Legal"), then the brand block (logo + tagline, both
/// centered) sits below, separated by a 28px gap. Padding is 40/32, not the
/// standard mobile gutter.
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  static const _gutter = 48.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.footer,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsive<double>(
                mobile: 40, tablet: 40, desktop: _gutter),
            vertical: context.responsive<double>(mobile: 0, desktop: 40),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1414),
            child: ResponsiveLayout(
              mobile: (_) => Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final c in Footer.columns) _linkColumn(c),
                      ],
                    ),
                    const SizedBox(height: 28),
                    _brand(centered: true),
                  ],
                ),
              ),
              desktop: (_) => Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 400, child: _brand()),
                    const SizedBox(width: 40),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final c in Footer.columns)
                            Expanded(child: _linkColumn(c)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _brand({bool centered = false}) => Column(
        crossAxisAlignment:
            centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.logoPortrait,
              width: 116, height: 116, filterQuality: FilterQuality.high),
          const SizedBox(height: 10),
          Padding(
            padding:
                centered ? EdgeInsets.zero : const EdgeInsets.only(left: 22),
            child: Column(
              crossAxisAlignment: centered
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                WlthyText(Footer.tagline,
                    textAlign: centered ? TextAlign.center : null,
                    style: FigmaText.footerTagline(AppColors.white)),
                const SizedBox(height: 17),
                WlthyText(Footer.subtitle,
                    textAlign: centered ? TextAlign.center : null,
                    style: FigmaText.footerSubtitle(AppColors.white)),
              ],
            ),
          ),
        ],
      );

  Widget _linkColumn(MapEntry<String, List<String>> col) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(col.key.toUpperCase(),
              style: FigmaText.footerColumnHeader(AppColors.white)),
          const SizedBox(height: 10),
          for (final link in col.value)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _FooterLink(link),
            ),
        ],
      );
}

/// A footer link. Scrolls to its section when one is registered in
/// [_footerTargets]; otherwise renders as plain text with no click affordance.
class _FooterLink extends StatelessWidget {
  const _FooterLink(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final text =
        WlthyText(label, style: FigmaText.footerLink(AppColors.white));
    final target = _footerTargets[label];
    if (target == null) return text;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => scrollToSection(target),
        child: text,
      ),
    );
  }
}
