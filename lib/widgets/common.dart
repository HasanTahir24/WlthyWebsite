import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/responsive.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'wlthy_text.dart';

/// Small uppercase eyebrow label that sits above section headings.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.onDark = false, this.color});

  final String text;
  final bool onDark;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return WlthyText(
      text.toUpperCase(),
      style: FigmaText.eyebrow(
        color ?? (onDark ? AppColors.onDarkMuted : AppColors.inkMuted),
      ),
    );
  }
}

/// Section heading block: optional eyebrow, headline and supporting body.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    this.eyebrow,
    required this.title,
    this.body,
    this.onDark = false,
    this.center = false,
    this.maxWidth,
    this.titleColor,
    this.eyebrowColor,
    this.bodyStyle,
  });

  final String? eyebrow;
  final String title;
  final String? body;
  final bool onDark;
  final bool center;
  final double? maxWidth;
  final Color? titleColor;
  final Color? eyebrowColor;

  /// Exact Figma style for [body], since "body" maps to a different text
  /// node per section (e.g. Franklin 13/20 vs Inter 11/21). Defaults to
  /// [FigmaText.cardBody] (Franklin w500 13/20), the most common case.
  final TextStyle Function(Color color)? bodyStyle;

  @override
  Widget build(BuildContext context) {
    final align = center ? TextAlign.center : TextAlign.start;
    final cross = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    final column = Column(
      crossAxisAlignment: cross,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (eyebrow != null) ...[
          Eyebrow(eyebrow!, onDark: onDark, color: eyebrowColor),
          const SizedBox(height: 16),
        ],
        WlthyText(
          title,
          textAlign: align,
          style: FigmaText.h2(
            titleColor ?? (onDark ? AppColors.onDark : AppColors.ink),
          ),
        ),
        if (body != null) ...[
          const SizedBox(height: 18),
          WlthyText(
            body!,
            textAlign: align,
            style: (bodyStyle ?? FigmaText.cardBody)(
              onDark ? AppColors.onDarkMuted : AppColors.inkMuted,
            ),
          ),
        ],
      ],
    );

    if (maxWidth == null) return column;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth!),
      child: column,
    );
  }
}

/// The wlthy logo lockup (gold "W" mark + "wlthy" wordmark).
///
/// The source artwork is dark, so on dark surfaces ([onDark]) it is tinted to
/// [AppColors.onDark] so it stays legible.
class WlthyWordmark extends StatelessWidget {
  const WlthyWordmark({super.key, this.onDark = false, this.height = 32});

  final bool onDark;

  /// Rendered height of the logo lockup in logical pixels.
  final double height;

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      AppImages.logo,
      height: height,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      semanticLabel: 'wlthy',
    );

    if (!onDark) return logo;

    return ColorFiltered(
      colorFilter: const ColorFilter.mode(AppColors.onDark, BlendMode.srcIn),
      child: logo,
    );
  }
}

/// A responsive grid that lays children out in [columns] on desktop and wraps
/// down to fewer columns on smaller screens.
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.desktopColumns = 3,
    this.tabletColumns = 2,
    this.mobileColumns = 1,
    this.spacing = 20,
    this.runSpacing = 20,
  });

  final List<Widget> children;
  final int desktopColumns;
  final int tabletColumns;
  final int mobileColumns;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    final columns = context.responsive(
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalSpacing = spacing * (columns - 1);
        final itemWidth = (constraints.maxWidth - totalSpacing) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}
