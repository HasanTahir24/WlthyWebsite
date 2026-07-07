import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      background: AppColors.footer,
      verticalPadding: context.responsive(mobile: 48, desktop: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveLayout(
            mobile: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _brand(context),
                const SizedBox(height: 32),
                _links(context),
              ],
            ),
            desktop: (_) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _brand(context)),
                Expanded(flex: 6, child: _links(context)),
              ],
            ),
          ),
          const SizedBox(height: 48),
          const Divider(color: AppColors.hairlineOnDark, height: 1),
          const SizedBox(height: 24),
          WlthyText('© 2026 wlthy Technologies FZ-LLC. All rights reserved.',
              style: FigmaText.footerLink(AppColors.onDarkMuted)),
        ],
      ),
    );
  }

  Widget _brand(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WlthyWordmark(onDark: true, height: 40),
          const SizedBox(height: 16),
          WlthyText(Footer.tagline, style: FigmaText.footerTagline(AppColors.onDark)),
          const SizedBox(height: 8),
          WlthyText(Footer.subtitle, style: FigmaText.footerSubtitle(AppColors.onDark)),
        ],
      );

  Widget _links(BuildContext context) => Wrap(
        spacing: 48,
        runSpacing: 32,
        children: [
          for (final col in Footer.columns)
            SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WlthyText(col.key.toUpperCase(),
                      style: FigmaText.footerColumnHeader(AppColors.onDark)),
                  const SizedBox(height: 16),
                  for (final link in col.value)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: WlthyText(link,
                          style: FigmaText.footerLink(AppColors.onDark)),
                    ),
                ],
              ),
            ),
        ],
      );
}
