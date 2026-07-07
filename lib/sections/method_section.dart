import 'package:flutter/material.dart';

import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';

/// "The wlthy Method" — the letters W L T H Y each carry a principle. A
/// diagonal periwinkle motif sweeps across the band in the Figma.
class MethodSection extends StatelessWidget {
  const MethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      background: AppColors.white,
      clip: true,
      foregroundOverlay: const _DiagonalMotif(),
      child: Column(
        children: [
          SectionHeader(
            eyebrow: Method.eyebrow,
            title: Method.title,
            body: Method.subtitle,
            center: true,
            maxWidth: 720,
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
        ],
      ),
    );
  }
}

class _Letter extends StatelessWidget {
  const _Letter(this.item);
  final StepItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.number, style: FigmaText.methodLetter(AppColors.ink)),
        const SizedBox(height: 12),
        Text(item.title.toUpperCase(),
            style: FigmaText.methodLetterTitle(AppColors.ink)),
        const SizedBox(height: 8),
        Text(item.body,
            style: FigmaText.methodLetterBody(const Color(0xFF5C5C58))),
      ],
    );
  }
}

class _DiagonalMotif extends StatelessWidget {
  const _DiagonalMotif();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Transform.rotate(
        angle: 0.35,
        child: Container(
          width: 120,
          margin: const EdgeInsets.only(right: 80),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.accent.withValues(alpha: 0.0),
                AppColors.accent,
                AppColors.accent.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
