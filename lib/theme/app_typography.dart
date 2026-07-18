import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Font-family helpers. Three brand faces, bundled as local variable fonts
/// (see `pubspec.yaml`) — no runtime network fetch:
///  * **Libre Franklin** (sans) — headings, body, nav, buttons, eyebrows.
///  * **Libre Baskerville** (serif) — card/block titles, descriptive copy.
///  * **Inter** — fine print / disclaimers / small UI text.
abstract final class AppType {
  static TextStyle sans(TextStyle style) =>
      style.copyWith(fontFamily: 'Libre Franklin');

  static TextStyle serif(TextStyle style) =>
      style.copyWith(fontFamily: 'Libre Baskerville');

  static TextStyle inter(TextStyle style) =>
      style.copyWith(fontFamily: 'Inter');

  /// The "wlthy" wordmark / large method letters — primary sans.
  static TextStyle wordmark({
    required double size,
    FontWeight weight = FontWeight.w700,
    double spacing = -0.5,
    Color? color,
  }) =>
      sans(TextStyle(
        fontSize: size,
        fontWeight: weight,
        letterSpacing: spacing,
        color: color,
      ));

  /// Minimal [TextTheme] — only used for Flutter defaults (e.g. TextField)
  /// that need *some* theme text style. Section copy should use [FigmaText]
  /// instead of `Theme.of(context).textTheme.*`, since those slots don't map
  /// 1:1 onto the Figma type scale.
  static TextTheme textTheme(Color color, Color muted) {
    return TextTheme(
      bodyMedium: sans(TextStyle(fontSize: 14, color: color)),
    );
  }
}

/// Exact text styles transcribed from the Figma file (node 213:91), keyed by
/// where they're used. Each entry is `family / weight / size / lineHeight`
/// exactly as read from the design — no approximated Material slots.
///
/// Every style takes an explicit [color] since the same style is reused on
/// light and dark bands.
abstract final class FigmaText {
  static TextStyle _f(double size, FontWeight w, double lineHeightPx, Color c,
          {double spacing = 0}) =>
      AppType.sans(TextStyle(
        fontSize: size,
        fontWeight: w,
        height: lineHeightPx / size,
        letterSpacing: spacing,
        color: c,
      ));

  static TextStyle _b(double size, FontWeight w, double lineHeightPx, Color c,
          {FontStyle style = FontStyle.normal}) =>
      AppType.serif(TextStyle(
        fontSize: size,
        fontWeight: w,
        height: lineHeightPx / size,
        color: c,
        fontStyle: style,
      ));

  static TextStyle _i(double size, FontWeight w, double lineHeightPx, Color c) =>
      AppType.inter(TextStyle(
        fontSize: size,
        fontWeight: w,
        height: lineHeightPx / size,
        color: c,
      ));

  // Eyebrow / category tag — Franklin w700 10/16, uppercase, wide tracking.
  static TextStyle eyebrow(Color c) => _f(10, FontWeight.w700, 16, c, spacing: 1.2);

  // Section H2 — Franklin w600 22/32. Used for every section's main title.
  static TextStyle h2(Color c) => _f(22, FontWeight.w600, 32, c);

  // Nav —────────────────────────────────────────────────────────────────
  static TextStyle navLink(Color c) => _f(14, FontWeight.w700, 19, c);
  static TextStyle navButton(Color c) => _f(12, FontWeight.w500, 17, c);

  // Hero —───────────────────────────────────────────────────────────────
  static TextStyle heroHeadline(Color c) => _f(36, FontWeight.w600, 48, c);
  static TextStyle heroSubtext(Color c) => _b(12, FontWeight.w400, 21, c);
  static TextStyle heroSupportLine(Color c) => _f(13, FontWeight.w500, 20, c);
  static TextStyle heroFinePrint(Color c) => _f(10, FontWeight.w500, 16, c);
  static TextStyle button(Color c) => _f(14, FontWeight.w500, 20, c);

  // Audience / problem / built-for / tracks cards —─────────────────────
  static TextStyle cardTitleSerif(Color c) => _b(14, FontWeight.w400, 20, c);
  static TextStyle cardBody(Color c) => _f(13, FontWeight.w500, 20, c);
  static TextStyle cardBodySmall(Color c) => _f(10, FontWeight.w500, 16, c);

  // Waitlist —───────────────────────────────────────────────────────────
  static TextStyle fieldLabel(Color c) => _f(13, FontWeight.w500, 20, c);
  static TextStyle fineprintInter9(Color c) => _i(9, FontWeight.w400, 17, c);
  static TextStyle fineprintInter9b(Color c) => _i(9, FontWeight.w400, 16, c);

  // Problem section body (uses Inter, not Baskerville).
  static TextStyle problemBody(Color c) => _i(11, FontWeight.w400, 21, c);

  // Approach —───────────────────────────────────────────────────────────
  static TextStyle approachTitle(Color c) => _f(36, FontWeight.w300, 32, c);
  static TextStyle approachBody(Color c) => _b(12, FontWeight.w400, 21, c);

  // Steps —──────────────────────────────────────────────────────────────
  static TextStyle stepNumber(Color c) => _f(20, FontWeight.w300, 30, c);

  // Method —─────────────────────────────────────────────────────────────
  static TextStyle methodSubtitle(Color c) => _f(13, FontWeight.w500, 20, c);
  static TextStyle methodDescription(Color c) => _b(12, FontWeight.w400, 21, c);
  static TextStyle methodLetter(Color c) => _f(45, FontWeight.w600, 50, c);
  static TextStyle methodLetterTitle(Color c) => _f(10, FontWeight.w700, 16, c);
  static TextStyle methodLetterBody(Color c) => _i(13, FontWeight.w400, 15, c);

  // Trust —──────────────────────────────────────────────────────────────
  static TextStyle trustItemTitle(Color c) => _f(13, FontWeight.w700, 20, c);

  // Pricing —────────────────────────────────────────────────────────────
  static TextStyle pricingSubtitle(Color c) => _b(14, FontWeight.w400, 20, c);
  static TextStyle tierName(Color c) => _f(26, FontWeight.w400, 20, c);
  static TextStyle tierPrice(Color c) => _f(14, FontWeight.w600, 20, c);
  static TextStyle tierButton(Color c) => _f(14, FontWeight.w400, 20, c);
  // Card description + bulleted feature list use the Baskerville serif.
  static TextStyle tierDescription(Color c) => _b(12, FontWeight.w400, 20, c);
  static TextStyle tierBullet(Color c) => _b(13, FontWeight.w500, 20, c);

  // Boundaries —─────────────────────────────────────────────────────────
  static TextStyle chip(Color c) => _f(13, FontWeight.w700, 20, c);
  static TextStyle footnoteSerif(Color c) => _b(12, FontWeight.w400, 21, c);

  // Coming soon —────────────────────────────────────────────────────────
  static TextStyle comingSoonBody(Color c) => _b(14, FontWeight.w400, 20, c);
  static TextStyle statusPill(Color c) => _i(11, FontWeight.w400, 18, c);

  // Company —────────────────────────────────────────────────────────────
  static TextStyle companyTitle(Color c) => _f(20, FontWeight.w800, 32, c);
  static TextStyle companyBody(Color c) => _f(13, FontWeight.w500, 20, c);
  static TextStyle companyQuote(Color c) =>
      _b(14, FontWeight.w400, 20, c);
  static TextStyle detailLabel(Color c) => _f(10, FontWeight.w700, 16, c);
  static TextStyle detailValue(Color c) => _f(10, FontWeight.w500, 16, c);

  // FAQ —────────────────────────────────────────────────────────────────
  static TextStyle faqQuestion(Color c) => _f(13, FontWeight.w500, 20, c);
  static TextStyle faqAnswer(Color c) => _b(12, FontWeight.w400, 21, c);

  // Footer —─────────────────────────────────────────────────────────────
  static TextStyle footerTagline(Color c) => _f(10, FontWeight.w500, 16, c);
  static TextStyle footerSubtitle(Color c) => _i(10, FontWeight.w400, 18, c);
  static TextStyle footerColumnHeader(Color c) => _f(10, FontWeight.w700, 16, c);
  static TextStyle footerLink(Color c) => _f(10, FontWeight.w500, 16, c);
}

/// Convenience accessors used across sections.
extension AppTextStyles on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;

  /// Uppercase eyebrow label (e.g. "THE PROBLEM").
  TextStyle get eyebrow => FigmaText.eyebrow(AppColors.inkMuted);
}
