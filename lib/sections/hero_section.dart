import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/wlthy_button.dart';
import '../widgets/wlthy_text.dart';

/// Hero band. On desktop/tablet the wide "hand holding phone" shot is a
/// full-bleed background (phone on the right) with the copy overlaid on the
/// open left side. On mobile the copy stacks above the portrait app shot.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return _mobile(context);
    return _desktop(context);
  }

  // Hero background image intrinsic aspect ratio (3020 x 1300).
  static const double _bgAspect = 3020 / 1300;

  Widget _desktop(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Band is at least as tall as the image's natural aspect at this width,
      // but grows to fit the copy if that's ever taller — never overflows.
      final minHeight = constraints.maxWidth / _bgAspect;
      return Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImages.heroBg,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                filterQuality: FilterQuality.high),
          ),
          // Legibility scrim over the left.
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0, 0.5, 0.72],
                  colors: [
                    Color(0xF2F5F5F3),
                    Color(0xCCF5F5F3),
                    Color(0x00F5F5F3),
                  ],
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.gutter, vertical: 56),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 540),
                    child: _copy(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _mobile(BuildContext context) {
    return Container(
      color: AppColors.cream,
      padding: EdgeInsets.fromLTRB(
          context.gutter, 40, context.gutter, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _copy(context),
          const SizedBox(height: 32),
          Center(
            child: Image.asset(AppImages.heroPhone,
                width: 300, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }

  Widget _copy(BuildContext context) {
    final headlineSize = context.responsive<double>(mobile: 26, tablet: 30, desktop: 36);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        WlthyText(HeroContent.eyebrow.toUpperCase(),
            style: FigmaText.eyebrow(AppColors.ink)),
        const SizedBox(height: 18),
        WlthyText(HeroContent.headline,
            style: AppType.sans(TextStyle(
              fontSize: headlineSize,
              fontWeight: FontWeight.w600,
              height: 48 / 36,
              color: AppColors.ink,
            ))),
        const SizedBox(height: 18),
        WlthyText(HeroContent.subtext, style: FigmaText.heroSubtext(AppColors.inkMuted)),
        const SizedBox(height: 12),
        WlthyText(HeroContent.support.toUpperCase(),
            style: FigmaText.heroSupportLine(AppColors.ink)),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            WlthyButton(HeroContent.primaryCta),
            WlthyButton(HeroContent.secondaryCta,
                variant: WlthyButtonVariant.outline),
          ],
        ),
        const SizedBox(height: 20),
        WlthyText(HeroContent.finePrint,
            style: FigmaText.heroFinePrint(AppColors.inkMuted)),
      ],
    );
  }
}
