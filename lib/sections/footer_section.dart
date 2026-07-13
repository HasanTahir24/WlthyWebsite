import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/wlthy_text.dart';

/// Footer (Figma 213:614, 1510×430, #251B10): a square wlthy logo with tagline
/// on the left, then three link columns (Product, Company, Legal). No divider
/// or copyright line in the file. Content starts at a 48px gutter.
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
                mobile: 20, tablet: 40, desktop: _gutter),
            vertical: 40,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1414),
            child: ResponsiveLayout(
              mobile: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _brand(),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 40,
                    runSpacing: 32,
                    children: [for (final c in Footer.columns) _linkColumn(c)],
                  ),
                ],
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

  Widget _brand() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.logoPortrait,
              width: 116, height: 116, filterQuality: FilterQuality.high),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WlthyText(Footer.tagline,
                    style: FigmaText.footerTagline(AppColors.white)),
                const SizedBox(height: 17),
                WlthyText(Footer.subtitle,
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
              child: WlthyText(link,
                  style: FigmaText.footerLink(AppColors.white)),
            ),
        ],
      );
}
