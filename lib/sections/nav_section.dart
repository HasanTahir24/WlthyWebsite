import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/scroll_registry.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/wlthy_text.dart';

/// Maps each nav label to the section it should scroll to.
final Map<String, GlobalKey> _navTargets = {
  'how it works': SectionKeys.howItWorks,
  'features': SectionKeys.features,
  'the wlthy method': SectionKeys.method,
  'trust': SectionKeys.trust,
  'company': SectionKeys.company,
};

/// Top navigation bar (Figma 213:92, 1510×120): logo left, links centred,
/// waitlist button right. Collapses to logo + menu on mobile.
class NavSection extends StatelessWidget {
  const NavSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.hairline)),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.gutter),
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
            child: SizedBox(
              width: double.infinity,
              height: context.isMobile ? 76 : 100,
              child: context.isDesktop
                  ? _desktop(context)
                  : _mobile(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktop(BuildContext context) {
    return Row(
      children: [
        const WlthyWordmark(height: 46),
        Expanded(
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final link in Nav.links)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            final target = _navTargets[link];
                            if (target != null) scrollToSection(target);
                          },
                          child: WlthyText(link,
                              style: _linkStyle,
                              boldWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const _NavButton(),
      ],
    );
  }

  Widget _mobile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const WlthyWordmark(height: 38),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: AppColors.ink),
        ),
      ],
    );
  }

  static TextStyle get _linkStyle => FigmaText.navLink(AppColors.ink);
}

class _NavButton extends StatelessWidget {
  const _NavButton();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => scrollToSection(SectionKeys.waitlist),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.ink.withValues(alpha: 0.55)),
          ),
          child: Text(Nav.cta, style: FigmaText.navButton(AppColors.ink)),
        ),
      ),
    );
  }
}
