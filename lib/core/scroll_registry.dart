import 'package:flutter/material.dart';

/// Anchors for the sections the nav bar and hero buttons scroll to.
abstract final class SectionKeys {
  static final howItWorks = GlobalKey();
  static final features = GlobalKey();
  static final method = GlobalKey();
  static final trust = GlobalKey();
  static final company = GlobalKey();
  static final waitlist = GlobalKey();
}

/// Smooth-scrolls the nearest [Scrollable] so [key]'s widget is visible.
void scrollToSection(GlobalKey key) {
  final ctx = key.currentContext;
  if (ctx == null) return;
  Scrollable.ensureVisible(
    ctx,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
}
