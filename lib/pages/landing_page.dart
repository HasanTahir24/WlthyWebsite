import 'package:flutter/material.dart';

import '../core/scroll_registry.dart';
import '../sections/approach_section.dart';
import '../sections/audience_cards_section.dart';
import '../sections/boundaries_section.dart';
import '../sections/built_for_section.dart';
import '../sections/company_section.dart';
import '../sections/faq_section.dart';
import '../sections/footer_section.dart';
import '../sections/hero_section.dart';
import '../sections/method_section.dart';
import '../sections/nav_section.dart';
import '../sections/coming_soon_section.dart';
import '../sections/pricing_section.dart';
import '../sections/problem_section.dart';
import '../sections/steps_section.dart';
import '../sections/tracks_section.dart';
import '../sections/trust_section.dart';
import '../sections/waitlist_section.dart';

/// The whole wlthy site is a single continuous scroll of full-bleed bands.
/// The nav stays pinned at the top; everything else scrolls beneath it.
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static final _sections = <Widget>[
    const HeroSection(),
    const AudienceCardsSection(),
    KeyedSubtree(key: SectionKeys.waitlist, child: const WaitlistSection()),
    const ProblemSection(),
    KeyedSubtree(key: SectionKeys.features, child: const ApproachSection()),
    const TracksSection(),
    KeyedSubtree(key: SectionKeys.howItWorks, child: const StepsSection()),
    KeyedSubtree(key: SectionKeys.method, child: const MethodSection()),
    const BuiltForSection(),
    KeyedSubtree(key: SectionKeys.trust, child: const TrustSection()),
    const PricingSection(),
    const BoundariesSection(),
    const ComingSoonSection(),
    KeyedSubtree(key: SectionKeys.company, child: const CompanySection()),
    const FaqSection(),
    const FooterSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const NavSection(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _sections,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
