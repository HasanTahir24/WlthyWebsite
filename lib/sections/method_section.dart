import 'package:flutter/material.dart';
import 'package:wlthy_website/core/app_assets.dart';
import 'package:wlthy_website/core/responsive.dart';

import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// "The wlthy Method" — the letters W L T H Y each carry a principle. A
/// diagonal periwinkle motif sweeps across the band in the Figma.
class MethodSection extends StatelessWidget {
  const MethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        
         Positioned.fill(
            child: Image.asset(
              context.isMobile ?  AppImages.methodBGMobile : AppImages.methodBG,
              fit: BoxFit.cover,
            ),
          ),
        SectionBand(
        background: Colors.transparent,
        clip: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SectionHeader(
              eyebrow: Method.eyebrow,
              title: Method.title,
              body: Method.subtitle,
              center: true,
              maxWidth: 720,
              eyebrowColor: AppColors.starDust,
              bodyStyle: FigmaText.methodDescription
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: WlthyText(
                Method.description,
                textAlign: TextAlign.center,
                style: FigmaText.methodDescription(const Color(0xFF9C9C97)),
              ),
            ),
            const SizedBox(height: 56),
            ResponsiveGrid(
              desktopColumns: 5,
              tabletColumns: 3,
              mobileColumns: 1,
              spacing: 24,
              runSpacing: 32,
              children: [for (final l in Method.letters) _Letter(l)],
            ),
            const SizedBox(height: 40),
      WlthyText(
                "Two goals. One move. Calm progress toward freedom.",
                textAlign: TextAlign.center,
                style: FigmaText.methodDescription(const Color(0xFF9C9C97)),
              ),
            SizedBox(height: context.isMobile ? 0 : 60),
          ],
        ),
      ),
     
      
      ]
    );
  }
}

class _Letter extends StatelessWidget {
  const _Letter(this.item);
  final StepItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(item.number, style: FigmaText.methodLetter(AppColors.gold)),
        const SizedBox(height: 12),
        Text(item.title.toUpperCase(),
            style: FigmaText.methodLetterTitle(AppColors.ink)),
        const SizedBox(height: 8),
        SizedBox(
          width: context.isMobile ? 180 : 135,
          child: Text(item.body,
              style: FigmaText.methodLetterBody(const Color(0xFF5C5C58)),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

