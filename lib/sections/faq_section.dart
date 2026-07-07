import 'package:flutter/material.dart';

import '../data/site_content.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common.dart';
import '../widgets/section_band.dart';
import '../widgets/wlthy_text.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      background: AppColors.cream,
      child: Column(
        children: [
          SectionHeader(
              eyebrow: Faq.eyebrow,
              title: Faq.title,
              center: true,
              titleColor: AppColors.accentInk),
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              children: [for (final item in Faq.items) _FaqTile(item)],
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatefulWidget {
  const _FaqTile(this.item);
  final FaqItem item;

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.hairline)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(vertical: 8),
          shape: const Border(),
          onExpansionChanged: (v) => setState(() => _open = v),
          trailing: Icon(_open ? Icons.remove : Icons.add,
              color: AppColors.ink, size: 22),
          title: WlthyText(widget.item.question,
              style: FigmaText.faqQuestion(AppColors.ink)),
          childrenPadding: const EdgeInsets.only(bottom: 20, right: 40),
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WlthyText(widget.item.answer,
                style: FigmaText.faqAnswer(const Color(0xFF5C5C58))),
          ],
        ),
      ),
    );
  }
}
