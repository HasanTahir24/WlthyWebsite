/// Central registry of bundled image assets.
abstract final class AppImages {
  static const _base = 'assets/images';

  /// Hand holding phone on the welcome/sign-up screen. Transparent PNG —
  /// composited directly onto the section background. Used in the hero.
  static const screen1 = '$_base/screen-1.png';
  static const screen1Mobile = '$_base/screen-1-mobile.png';

  /// Hand holding phone showing the wlthy OS net-worth dashboard.
  /// Transparent PNG. Used in the "Four steps" section.
  static const screen2 = '$_base/screen-2.png';
  static const screen2Mobile = '$_base/screen-2-mobile.png';

  /// Phone floating, showing the Freedom Plan screen. Transparent PNG. Used
  /// in the "Coming soon" banner.
  static const screen3 = '$_base/screen-3.png';

  /// Horizontal logo lockup: gold "W" mark + "wlthy" wordmark on a transparent
  /// background. Dark artwork — tint white when placed on dark surfaces.
  static const logo = '$_base/wlthy_logo.png';

  /// Square footer logo (gold mark over "wlthy"), baked onto the footer's
  /// #251B10 brown so it blends into the band.
  static const logoPortrait = '$_base/wlthy_logo_portrait.png';

  /// Botanical shadow texture behind the "Who wlthy is built for" section.
  static const builtForBg = '$_base/whoIsWealthyBuildForBG.jpg';

  //Method Page
static const methodBG = '$_base/method-bg.jpg';
  static const methodBGMobile = '$_base/method-bg-mobile.jpg';
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
