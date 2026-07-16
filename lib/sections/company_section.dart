import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// Deep navy "company behind wlthy" band (Figma 213:513, 1510×294): title,
/// description and gold quote on the left; a compact label|value detail table
/// on the right with a FOLLOW US row of white brand glyphs.
class CompanySection extends StatelessWidget {
  const CompanySection({super.key});

  static const _label = Color(0xFF9C9C97);
  static const _value = Color(0xFF5C5C58);

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      gradient: AppColors.companyBand,
      horizontalPadding: context.isMobile ? 40 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WlthyText(Company.eyebrow.toUpperCase(),
              style: FigmaText.eyebrow(_label)),
          const SizedBox(height: 6),
          ResponsiveLayout(
            mobile: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _intro(context),
                const SizedBox(height: 28),
                _details(context),
              ],
            ),
            desktop: (_) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _intro(context)),
                const SizedBox(width: 40),
                SizedBox(width: 472, child: _details(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _intro(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(Company.title,
              style: FigmaText.companyTitle(AppColors.white)),
          const SizedBox(height: 11),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 403),
            child: WlthyText(Company.description,
                style: FigmaText.companyBody(const Color(0xFFF5F5F3))),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 487),
            child: WlthyText(Company.quote,
                style: FigmaText.companyQuote(AppColors.taupe)),
          ),
        ],
      );

  Widget _details(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final d in Company.details) ...[
            _row(
              d.key.toUpperCase(),
              WlthyText(d.value, style: FigmaText.detailValue(_value)),
            ),
            const SizedBox(height: 10),
          ],
          _row('FOLLOW US', const _SocialRow()),
        ],
      );

  /// Label (92px slot) + value side by side, as in the Figma table.
  Widget _row(String label, Widget value) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: WlthyText(label, style: FigmaText.detailLabel(_label)),
          ),
          Expanded(child: value),
        ],
      );
}

/// Plain white brand glyphs, no badges (Figma order: LinkedIn, Instagram,
/// Facebook, TikTok, X).
class _SocialRow extends StatelessWidget {
  const _SocialRow();

  static const _icons = <String>[
    'assets/icons/social_linkedin.png',
    'assets/icons/social_instagram.png',
    'assets/icons/social_facebook.png',
    'assets/icons/social_tiktok.png',
    'assets/icons/social_x.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final icon in _icons)
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Image.asset(
              icon,
              height: 18,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
      ],
    );
  }
}
