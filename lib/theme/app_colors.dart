import 'package:flutter/material.dart';

/// Central colour palette for the wlthy marketing site.
///
/// Values are the exact fills from the Figma design (node 213:91), pulled via
/// the Figma REST API. The site is built from full-bleed horizontal "bands",
/// several of which use radial or linear gradients.
abstract final class AppColors {
  // Base surfaces ----------------------------------------------------------
  /// Primary page background — warm off-white / cream (Figma #F5F5F3).
  static const cream = Color(0xFFF5F5F3);

  /// Neutral grey panel band (Figma #D7D7D7).
  static const sand = Color(0xFFD7D7D7);

  static const white = Color(0xFFFFFFFF);

  // Text -------------------------------------------------------------------
  static const ink = Color(0xFF1A1712);
  static const inkMuted = Color(0xFF6E6A63);
  static const onDark = Color(0xFFF5F3EF);
  static const onDarkMuted = Color(0xFFB9B2A6);
  static const gold = Color(0xFF9F8566);
  static const starDust = Color(0xFF9C9C97);

  // Accent -----------------------------------------------------------------
  /// Periwinkle blue (Figma #83AAFF) — product UI + soft band highlights.
  static const accent = Color(0xFF83AAFF);
  static const accentSoft = Color(0xFF83AAFF);

  /// Link/number accent blue (Figma #4285F4) — step numbers, FAQ title, tags.
  static const accentInk = Color(0xFF4285F4);

  // Gradient stops ---------------------------------------------------------
  static const _stopBrown = Color(0xFF635340);
  static const _stopNavy = Color(0xFF1E3C6D);
  static const _stopBlack = Color(0xFF000000);
  static const _brownDeep = Color(0xFF393025);

  /// Taupe (Figma #9F8566) — waitlist CTA + tracks band top.
  static const taupe = Color(0xFF9F8566);

  /// Mobile Gray
  static const mobileGray = Color(0xFFD5D5D5);

  // The Figma dark bands are radial gradients with one axis stretched huge, so
  // they read as directional linears. Stops (0.17 / 0.62 / 1.0) are exact.

  /// Audience-cards band — horizontal brown (left) → navy → black (right).
  static const audienceBand = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [_stopBrown, _stopNavy, _stopBlack],
    stops: [0.17, 0.62, 1.0],
  );

  /// Pricing band — vertical brown (top) → navy → black (bottom).
  static const pricingBand = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [_stopBrown, _stopNavy, _stopBlack],
    stops: [0.17, 0.62, 1.0],
  );

  /// Company band — vertical navy (top) → black (bottom).
  static const companyBand = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [_stopNavy, _stopBlack],
  );

  /// Taupe → deep brown vertical band ("Six things wlthy tracks for you").
  static const taupeBand = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [taupe, _brownDeep],
  );

  /// White → periwinkle band ("Money feels heavier…"), Figma #FFFFFF → #83AAFF.
  static const problemBand = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [white, accent],
  );

  // Cards on dark bands ----------------------------------------------------
  /// Translucent panel used for cards sitting on the dark radial bands.
  static const cardOnDark = Color(0x1AFFFFFF);
  static const cardOnDarkStrong = Color(0x26FFFFFF);

  // Solid band colours -----------------------------------------------------
  static const footer = Color(0xFF251B10);

  // Lines ------------------------------------------------------------------
  static const hairline = Color(0xFFE0DCD4);
  static const hairlineOnDark = Color(0x22FFFFFF);
}
