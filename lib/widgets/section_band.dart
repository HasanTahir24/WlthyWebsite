import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../theme/app_colors.dart';

/// A full-bleed horizontal band that centres its child to the max content
/// width and applies responsive vertical + horizontal padding.
///
/// Every top-level section of the page is wrapped in one of these so the
/// continuous scroll reads as a stack of coloured bands, matching the Figma.
class SectionBand extends StatelessWidget {
  const SectionBand({
    super.key,
    required this.child,
    this.background,
    this.gradient,
    this.verticalPadding,
    this.maxWidth = Breakpoints.maxContentWidth,
    this.clip = false,
    this.foregroundOverlay,
    this.image,
  });

  final Widget child;
  final Color? background;
  final Gradient? gradient;
  final double? verticalPadding;
  final double maxWidth;
  final bool clip;

  /// Optional full-bleed background image for the band.
  final DecorationImage? image;

  /// Optional decorative widget painted behind [child] but within the band
  /// (e.g. the diagonal motif). Positioned to fill.
  final Widget? foregroundOverlay;

  @override
  Widget build(BuildContext context) {
    // Figma bands use ~40px vertical padding; keep that (was far too large).
    final vPad = verticalPadding ??
        context.responsive<double>(mobile: 40, tablet: 40, desktop: 44);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: gradient == null ? (background ?? AppColors.cream) : null,
        gradient: gradient,
        image: image,
      ),
      clipBehavior: clip ? Clip.hardEdge : Clip.none,
      child: Stack(
        children: [
          if (foregroundOverlay != null) Positioned.fill(child: foregroundOverlay!),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: vPad,
                horizontal: context.gutter,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: SizedBox(width: double.infinity, child: child),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
