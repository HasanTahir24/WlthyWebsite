import 'package:flutter/widgets.dart';

/// Breakpoints for the site. The Figma provides a desktop (1512px) and a mobile
/// (393px) design; tablet is interpolated.
enum FormFactor { mobile, tablet, desktop }

abstract final class Breakpoints {
  static const double tablet = 768;
  static const double desktop = 1080;

  /// Max content width — the Figma content column is ~1000px (256px gutters
  /// within the 1512px frame). Content is centred with gutters beyond this.
  static const double maxContentWidth = 1000;
}

FormFactor formFactorOf(double width) {
  if (width >= Breakpoints.desktop) return FormFactor.desktop;
  if (width >= Breakpoints.tablet) return FormFactor.tablet;
  return FormFactor.mobile;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  FormFactor get formFactor => formFactorOf(screenWidth);

  bool get isMobile => formFactor == FormFactor.mobile;
  bool get isTablet => formFactor == FormFactor.tablet;
  bool get isDesktop => formFactor == FormFactor.desktop;

  /// Pick a value per form factor, falling back to smaller definitions.
  T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    switch (formFactor) {
      case FormFactor.desktop:
        return desktop ?? tablet ?? mobile;
      case FormFactor.tablet:
        return tablet ?? mobile;
      case FormFactor.mobile:
        return mobile;
    }
  }

  /// Horizontal page gutter.
  double get gutter =>
      responsive<double>(mobile: 20, tablet: 40, desktop: 64);
}

/// Builds different layouts per form factor without repeating MediaQuery logic.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder desktop;

  @override
  Widget build(BuildContext context) {
    switch (context.formFactor) {
      case FormFactor.desktop:
        return desktop(context);
      case FormFactor.tablet:
        return (tablet ?? desktop)(context);
      case FormFactor.mobile:
        return mobile(context);
    }
  }
}
