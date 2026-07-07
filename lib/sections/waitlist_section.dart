import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

/// "Join the early wlthy list" (Figma 213:154): intro on the left, a light
/// form with label-above underline fields and a taupe CTA on the right.
class WaitlistSection extends StatelessWidget {
  const WaitlistSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      background: AppColors.cream,
      child: ResponsiveLayout(
        mobile: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_intro(context), const SizedBox(height: 32), _form(context)],
        ),
        desktop: (_) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 5, child: _intro(context)),
            const SizedBox(width: 64),
            Expanded(flex: 6, child: _form(context)),
          ],
        ),
      ),
    );
  }

  Widget _intro(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(Waitlist.title, style: FigmaText.h2(AppColors.ink)),
          const SizedBox(height: 12),
          WlthyText(Waitlist.body,
              style: FigmaText.cardBody(const Color(0xFF5C5C58))),
          const SizedBox(height: 14),
          WlthyText(Waitlist.disclaimer,
              style: FigmaText.fineprintInter9(const Color(0xFF9C9C97))),
        ],
      );

  Widget _form(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _field('First name')),
              const SizedBox(width: 32),
              Expanded(child: _field('Email address')),
            ],
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: _field('Country of residence'),
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: AppColors.hairline),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: WlthyText(Waitlist.consent,
                    style: FigmaText.fineprintInter9b(const Color(0xFF9C9C97))),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _taupeButton(Waitlist.cta),
        ],
      );

  Widget _field(String label) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          WlthyText(label, style: FigmaText.fieldLabel(const Color(0xFF5C5C58))),
          TextField(
            style: AppType.sans(
                const TextStyle(fontSize: 14, color: AppColors.ink)),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.hairline),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.ink),
              ),
            ),
          ),
        ],
      );

  Widget _taupeButton(String label) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.taupe,
            borderRadius: BorderRadius.circular(8),
          ),
          child: WlthyText(label, style: FigmaText.button(AppColors.white)),
        ),
      );
}
