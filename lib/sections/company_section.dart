import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// Deep navy "company behind wlthy" band.
class CompanySection extends StatelessWidget {
  const CompanySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      gradient: AppColors.companyBand,
      child: ResponsiveLayout(
        mobile: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_intro(context), const SizedBox(height: 32), _details(context)],
        ),
        desktop: (_) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 6, child: _intro(context)),
            const SizedBox(width: 64),
            Expanded(flex: 5, child: _details(context)),
          ],
        ),
      ),
    );
  }

  Widget _intro(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Eyebrow(Company.eyebrow, onDark: true),
          const SizedBox(height: 16),
          WlthyText(Company.title, style: FigmaText.companyTitle(AppColors.onDark)),
          const SizedBox(height: 18),
          WlthyText(Company.description,
              style: FigmaText.companyBody(const Color(0xFFF5F5F3))),
          const SizedBox(height: 24),
          WlthyText(Company.quote, style: FigmaText.companyQuote(AppColors.taupe)),
        ],
      );

  Widget _details(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final d in Company.details)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WlthyText(d.key.toUpperCase(),
                      style: FigmaText.detailLabel(const Color(0xFF9C9C97))),
                  const SizedBox(height: 4),
                  WlthyText(d.value,
                      style: FigmaText.detailValue(const Color(0xFF5C5C58))),
                ],
              ),
            ),
          WlthyText('FOLLOW US',
              style: FigmaText.detailLabel(const Color(0xFF9C9C97))),
          const SizedBox(height: 10),
          const _SocialRow(),
        ],
      );
}

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  // Order matches the Figma follow-us row: LinkedIn, Instagram, Facebook,
  // TikTok, X.
  static const _icons = [
    Icons.business_center_outlined, // LinkedIn placeholder
    Icons.camera_alt_outlined, // Instagram placeholder
    Icons.facebook, // Facebook
    Icons.music_note_outlined, // TikTok placeholder
    Icons.close, // X
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final icon in _icons)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, size: 14, color: AppColors.white),
            ),
          ),
      ],
    );
  }
}
