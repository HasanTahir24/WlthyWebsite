import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/wlthy_text.dart';

/// Hero band (Figma 213:107): a soft grey vertical gradient with the copy
/// vertically centred on the left and the large hand-holding-phone cutout
/// bleeding off the top and bottom on the right. Mobile stacks the phone below.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  // Figma hero background: light grey at the top fading lighter toward the
  // bottom (a black→transparent gradient over the page).
  static const _bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFCDCDCB), Color(0xFFE9E9E7)],
  );

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return _mobile(context);
    return _desktop(context);
  }

  Widget _desktop(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: const BoxDecoration(gradient: _bgGradient),
        child: Center(
          // Gutter OUTSIDE the max-width column, exactly like SectionBand, so
          // the hero shares the same 1000px grid as every other section.
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.gutter),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                  // Copy sizes the band; kept to the left half.
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 72),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: _copy(context),
                    ),
                  ),
                  // Phone bleeds off the top/bottom (clipped by the band).
                  Positioned(
                    top: -40,
                    bottom: -200,
                    right: -32,
                    child: Image.asset(
                      AppImages.screen1,
                      fit: BoxFit.fitHeight,
                      filterQuality: FilterQuality.high,
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

  Widget _mobile(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: _bgGradient),
      child: Padding(
        padding: EdgeInsets.fromLTRB(context.gutter, 40, context.gutter, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _copy(context),
            const SizedBox(height: 24),
            Center(
              child: Image.asset(AppImages.screen1,
                  width: 280, fit: BoxFit.contain),
            ),
          ],
        ),
      ),
    );
  }

  Widget _copy(BuildContext context) {
    final headlineSize =
        context.responsive<double>(mobile: 26, tablet: 30, desktop: 36);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // White pill eyebrow.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(999),
          ),
          child: WlthyText(HeroContent.eyebrow.toUpperCase(),
              style: FigmaText.eyebrow(const Color(0xFF1E1E1E))),
        ),
        const SizedBox(height: 24),
        WlthyText(HeroContent.headline,
            style: AppType.sans(TextStyle(
              fontSize: headlineSize,
              fontWeight: FontWeight.w600,
              height: 48 / 36,
              color: AppColors.ink,
            ))),
        const SizedBox(height: 20),
        WlthyText(HeroContent.subtext,
            style: FigmaText.heroSubtext(const Color(0xFF1E1E1E))),
        const SizedBox(height: 16),
        WlthyText(HeroContent.support,
            style: FigmaText.heroSupportLine(const Color(0xFF1E1E1E))),
        const SizedBox(height: 24),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PrimaryButton(HeroContent.primaryCta),
            const SizedBox(width: 24),
            _TextButton(HeroContent.secondaryCta),
          ],
        ),
        const SizedBox(height: 18),
        WlthyText(HeroContent.finePrint,
            style: FigmaText.heroFinePrint(const Color(0xFF1E1E1E))),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.taupe,
          borderRadius: BorderRadius.circular(8),
        ),
        child: WlthyText(label, style: FigmaText.button(AppColors.white)),
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: WlthyText(label,
          style: FigmaText.button(const Color(0xFF5C5C58))
              .copyWith(decoration: TextDecoration.underline)),
    );
  }
}
