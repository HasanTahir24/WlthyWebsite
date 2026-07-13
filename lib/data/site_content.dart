/// All marketing copy for the wlthy site, transcribed from the Figma design
/// (node 213:91). Keeping it in one place makes the section widgets thin and
/// the copy easy to review/update.
library;

class FeatureItem {
  const FeatureItem(this.title, this.body);
  final String title;
  final String body;
}

class PricingTier {
  const PricingTier({
    required this.name,
    required this.tagline,
    required this.price,
    required this.description,
    required this.includes,
    required this.cta,
    this.highlighted = false,
  });

  final String name;
  final String tagline;
  final String price;
  final String description;
  final List<String> includes;
  final String cta;
  final bool highlighted;
}

class FaqItem {
  const FaqItem(this.question, this.answer);
  final String question;
  final String answer;
}

abstract final class Nav {
  static const links = <String>[
    'how it works',
    'features',
    'the wlthy method',
    'trust',
    'company',
  ];
  static const cta = 'Join the waitlist';
}

abstract final class HeroContent {
  static const eyebrow = 'Clarity-first wealth tracking';
  static const headline =
      'You need more than a finance app. You need a clear picture. '
      'Join wlthy to see yours.';
  static const subtext =
      'Your money is spread across income, spending, assets, debts, crypto, '
      'property, and plans. wlthy brings it into one calm view — so you can '
      'understand where you stand and what to do next.';
  static const support =
      'A clarity-first wealth app for modern professionals, builders, creators, '
      'and investors who want financial freedom without spreadsheets, noise, '
      'or pressure.';
  static const finePrint =
      'Currently in development by wlthy Technologies FZ-LLC, registered in '
      'Ras Al Khaimah, United Arab Emirates.  |  iOS & Android app in '
      'development';
  static const primaryCta = 'Join the waitlist';
  static const secondaryCta = 'See how it works';
}

/// A dark hero card: small label, a serif headline, and a body paragraph.
class AudienceCard {
  const AudienceCard(this.label, this.title, this.body);
  final String label;
  final String title;
  final String body;
}

/// The four dark cards directly under the hero (Figma 213:124).
abstract final class Audience {
  static const cards = <AudienceCard>[
    AudienceCard(
      'Freedom number',
      'You keep saying "one day." wlthy turns it into a number.',
      'Calculate and track the monthly income target that represents your path '
          'toward financial freedom.',
    ),
    AudienceCard(
      'Scattered money',
      'Your money has too many tabs open.',
      'Salary, cards, crypto, property, loans, and savings should not live in '
          'separate worlds.',
    ),
    AudienceCard(
      'High earners',
      'Good income does not always mean financial clarity.',
      'wlthy helps you see what stays, what leaks, and what moves you forward.',
    ),
    AudienceCard(
      'Crypto / investors',
      'Track wealth without turning your life into a trading screen.',
      'See crypto, property, cash, investments, debts, and income in one calm '
          'structure.',
    ),
  ];
}

abstract final class Waitlist {
  static const title = 'Join the early wlthy list.';
  static const body =
      'Get early access updates, product previews, and first access when '
      'wlthy opens for launch.';
  static const disclaimer =
      'No spam. No hype. Just clear progress toward a calmer way to build wealth.';
  static const consent =
      'I agree to receive wlthy product updates, launch information, and early '
      'access communications. I can unsubscribe at any time.';
  static const cta = 'Join the early list';
}

abstract final class Problem {
  static const eyebrow = 'The problem';
  static const title =
      'Money feels heavier when you cannot see the whole picture.';
  static const body =
      'Most people do not have one financial life. They have fragments: salary, '
      'cards, savings, crypto, property, loans, and spreadsheets. wlthy is being '
      'built to bring that into one calm view.';
  static const points = <FeatureItem>[
    FeatureItem(
      'Scattered accounts',
      'Your money is spread across platforms, apps, assets, and obligations.',
    ),
    FeatureItem(
      'Unclear progress',
      'You earn, spend, save, invest, and repay, but cannot see if you are '
          'moving forward.',
    ),
    FeatureItem(
      'No next step',
      'Most tools show data. wlthy helps turn your numbers into one clear move.',
    ),
  ];
}

abstract final class Approach {
  static const eyebrow = 'The WLTHY approach';
  static const title = 'One calm view for your wealth journey.';
  static const body =
      'wlthy starts with a guided Wealth Audit. You enter income, monthly costs, '
      'assets, liabilities, and passive income. Estimates are welcome. You can '
      'refine everything over time. Not everything. Just what matters.';
}

abstract final class Tracks {
  static const title = 'Six things wlthy tracks for you';
  static const items = <FeatureItem>[
    FeatureItem('Freedom Number',
        'See the monthly income target behind your financial freedom.'),
    FeatureItem('Net Worth', 'Understand what you own minus what you owe.'),
    FeatureItem('Runway',
        'See how many months of life your available cash could cover.'),
    FeatureItem('One Monthly Move',
        'Focus on the next practical action instead of drowning in financial noise.'),
    FeatureItem('Assets & Liabilities',
        'Bring cash, crypto, property, investments, and debts into one structure.'),
    FeatureItem('Cashflow Pulse',
        'Know whether the month is building, holding, or leaking.'),
  ];
}

class StepItem {
  const StepItem(this.number, this.title, this.body);
  final String number;
  final String title;
  final String body;
}

abstract final class Steps {
  static const eyebrow = 'Simple by design';
  static const title = 'Four steps to your full picture';
  static const items = <StepItem>[
    StepItem('01', 'Complete your Wealth Audit',
        'Enter income, costs, assets, liabilities, and passive income.'),
    StepItem('02', 'See your Freedom Number',
        'Turn financial freedom into a number you can track.'),
    StepItem('03', 'Understand your position',
        'View net worth, runway, cashflow, and progress in one place.'),
    StepItem('04', 'Make one move each month',
        'Protect your buffer, reduce pressure, build assets, or strengthen your plan.'),
  ];
}

abstract final class Method {
  static const eyebrow = 'Our framework';
  static const title = 'The wlthy Method';
  static const subtitle =
      'Clarity → Stability → One Move → Compounding → Freedom';
  static const description =
      'A calm, repeatable framework for turning money into a plan you can '
      'actually follow.';
  static const footnote =
      'Two goals. One move. Calm progress toward freedom.';
  static const letters = <StepItem>[
    StepItem('w', 'Write the Truth',
        'Bring your financial life into one clear picture.'),
    StepItem('l', 'Lower Pressure',
        'Protect runway, obligations, and breathing room first.'),
    StepItem('t', 'Transfer Surplus',
        'Turn leftover money into an intentional monthly move.'),
    StepItem('h', 'Hold Quality Assets',
        'Build wealth with discipline, patience, and structure.'),
    StepItem('y', 'Yield & You-Time',
        'Track progress toward income, independence, and freedom of time.'),
  ];
}

abstract final class BuiltFor {
  static const eyebrow = 'Built for modern money lives';
  static const title = 'Who wlthy is built for';
  static const cards = <FeatureItem>[
    FeatureItem('Digital professional',
        'You earn, build, and manage life across too many platforms.'),
    FeatureItem('Builder / Creator',
        'Your income may come from salary, clients, projects, content, or business.'),
    FeatureItem('Crypto-curious investor',
        'You understand the new money world, but do not want your life to become a trading screen.'),
    FeatureItem('Freedom-seeker',
        'You want options, breathing room, ownership, and control over your time.'),
  ];
}

abstract final class Trust {
  static const eyebrow = 'Trust before features';
  static const title = 'Built around what money tools should never do';
  static const items = <FeatureItem>[
    FeatureItem('You stay in control',
        'Your numbers can be confirmed, adjusted, or updated.'),
    FeatureItem(
        'No shame', 'wlthy does not use fear, guilt, or panic language.'),
    FeatureItem('No casino energy',
        'wlthy is not built to make users check markets all day.'),
    FeatureItem('No banking or lending',
        'wlthy is not a bank, lender, broker, exchange, or wallet.'),
    FeatureItem('Manual-first at launch',
        'The first version focuses on user-entered data and clear assumptions.'),
    FeatureItem('Education and planning',
        'wlthy helps users track, understand, and plan. Not financial advice.'),
  ];
}

abstract final class Pricing {
  static const eyebrow = 'Start your wealth journey';
  static const title = 'Your money needs clarity first. Then a plan.';
  static const subtitle = 'Start with clarity. Unlock the plan when you\'re ready.';
  static const body =
      'wlthy helps you see your full money picture, calculate your Freedom '
      'Number, and make one calm move toward freedom each month.';

  static const tiers = <PricingTier>[
    PricingTier(
      name: 'wlthy start',
      tagline: 'Start with clarity',
      price: 'Free',
      description:
          'Take your first Wealth Check, see your Freedom Number, and understand '
          'where you stand.',
      includes: [
        'Wealth Check',
        'Freedom Number',
        'Starter Command Centre',
        'Basic Own vs Owe view',
        'Current-month Check-Up',
        'Freedom Plan preview',
      ],
      cta: 'Start with clarity',
    ),
    PricingTier(
      name: 'wlthy plus',
      tagline: 'Turn your numbers into a plan',
      price: '\$12.99/month or \$99.99/year',
      description:
          'Unlock the full wlthy OS: track your wealth, review your month, follow '
          'your Freedom Plan, and make one clear move at a time.',
      includes: [
        'Full Command Centre',
        'Full Own vs Owe tracking',
        'Unlimited assets and debts',
        'Monthly Check-Up history',
        'Freedom Plan',
        'Two Goals + One Move',
        'Playbooks',
        'wlthy Coach',
        'Quiet Signals',
        'Wealth Story Simulator',
      ],
      cta: 'Unlock wlthy plus',
      highlighted: true,
    ),
    PricingTier(
      name: 'wlthy founders',
      tagline: 'Build the future of calm wealth with us',
      price: 'From \$299 one-time',
      description:
          'For early believers who want lifetime access to wlthy Plus and a voice '
          'in shaping the product before public launch.',
      includes: [
        'Lifetime wlthy Plus',
        'Founders badge',
        'Early feature access',
        'Private founder updates',
        'Priority feedback channel',
        'Locked lifetime access',
      ],
      cta: 'Get Founders Access',
    ),
  ];
}

abstract final class Boundaries {
  static const eyebrow = 'Clear boundaries';
  static const title = 'wlthy is not';
  static const chips = <String>[
    'A trading app',
    'A bank',
    'A lender',
    'A crypto wallet',
    'A promise of wealth',
    'A broker',
    'A budgeting punishment tool',
  ];
  static const footnote =
      'wlthy is a clarity-first wealth companion that helps you see your money, '
      'understand your position, and make better monthly decisions.';
}

abstract final class ComingSoon {
  static const eyebrow = 'Currently in development';
  static const title = 'Coming soon on iOS & Android';
  static const body =
      'wlthy is being developed for iOS and Android. The first version focuses '
      'on guided financial clarity: Wealth Audit, Freedom Number, net worth, '
      'runway, cashflow pulse, and a calm monthly check-up.';
  static const cta = 'Join the early list';
  static const statuses = <String>[
    'iOS — in development',
    'Android — in development',
  ];
}

abstract final class Company {
  static const eyebrow = 'The company behind';
  static const title = 'wlthy.app';
  static const description =
      'Designed & Developed by wlthy Technologies FZ-LLC, a company registered in '
      'Ras Al Khaimah, United Arab Emirates.';
  static const quote =
      '"wlthy is built from a simple belief: true wealth is freedom and freedom '
      'becomes easier to build when you can see your numbers clearly."';
  static const details = <MapEntry<String, String>>[
    MapEntry('Company', 'wlthy Technologies FZ-LLC'),
    MapEntry('Registered', 'Ras Al Khaimah, United Arab Emirates'),
    MapEntry('Address',
        'VUNE2036, Compass Building, Al Hulaila Industrial Zone-FZ, RAK, UAE'),
    MapEntry('Email', 'hello@wlthy.app'),
    MapEntry('Website', 'wlthy.app'),
  ];
}

abstract final class Faq {
  static const eyebrow = 'Questions before you join?';
  static const title = 'Frequently asked questions';
  static const items = <FaqItem>[
    FaqItem('Is wlthy available now?',
        'wlthy is currently in development. Join the waitlist for early access updates.'),
    FaqItem('Is wlthy a budgeting app?',
        'Not in the traditional sense. wlthy helps users understand their full wealth picture, not just track spending.'),
    FaqItem('Is wlthy a bank or investment platform?',
        'No. wlthy is not a bank, lender, broker, exchange, or wallet.'),
    FaqItem('Will wlthy connect to my bank?',
        'The first version is planned as manual-first. Future integrations may be added later.'),
    FaqItem('What is a Freedom Number?',
        'Your Freedom Number is the monthly income target behind your financial freedom goal.'),
    FaqItem('Who is wlthy for?',
        'Modern professionals, creators, builders, entrepreneurs, and investors who want clarity over noise.'),
    FaqItem('Does wlthy give financial advice?',
        'No. wlthy provides planning, tracking, education, and general insights based on user inputs. It does not provide individualised financial advice.'),
  ];
}

abstract final class Footer {
  static const tagline = 'See your full money picture. Move with intention.';
  static const subtitle = 'Planning  ·  Tracking  ·  Education';
  static const columns = <MapEntry<String, List<String>>>[
    MapEntry('Product',
        ['How it works', 'Features', 'The wlthy Method', 'Join the waitlist']),
    MapEntry('Company', ['About', 'Trust', 'Contact']),
    MapEntry('Legal', ['Privacy Policy', 'Terms of Use', 'Disclaimer']),
  ];
}
