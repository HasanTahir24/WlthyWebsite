/// Central registry of bundled image assets.
abstract final class AppImages {
  static const _base = 'assets/images';

  /// Portrait "hand holding phone" showing the Freedom Number dashboard.
  /// Used as the hero visual.
  static const heroPhone = '$_base/screen_1.png';

  /// Wide banner: hands holding a phone on the onboarding screen, open space on
  /// the left. Used for both the "Coming soon" banner and the "Four steps" band.
  static const phoneBanner = '$_base/HorizontalBorder.jpg';

  /// Horizontal logo lockup: gold "W" mark + "wlthy" wordmark on a transparent
  /// background. Dark artwork — tint white when placed on dark surfaces.
  static const logo = '$_base/wlthy_logo.png';

  // Section background images (exported from the Figma fills) ---------------
  /// Hero: hand holding phone on the right, open grey space on the left.
  static const heroBg = '$_base/hero_bg.png';

  /// "Four steps" band background (same shot as [phoneBanner]).
  static const stepsBg = '$_base/HorizontalBorder.jpg';

  /// Botanical shadow texture behind the "Who wlthy is built for" section.
  static const builtForBg = '$_base/whoIsWealthyBuildForBG.jpg';

  // Track icons (exported SVG from Figma), in the order of Tracks.items.
  static const _icons = 'assets/icons';
  static const trackIcons = <String>[
    '$_icons/ic_freedom_number.svg',
    '$_icons/ic_net_worth.svg',
    '$_icons/ic_runway.svg',
    '$_icons/ic_one_monthly_move.svg',
    '$_icons/ic_assets_liabilities.svg',
    '$_icons/ic_cashflow_pulse.svg',
  ];
}
