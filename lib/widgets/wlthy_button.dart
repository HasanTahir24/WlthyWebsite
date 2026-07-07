import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum WlthyButtonVariant { filled, outline, ghost }

/// Pill button used for CTAs across the site.
class WlthyButton extends StatelessWidget {
  const WlthyButton(
    this.label, {
    super.key,
    this.onPressed,
    this.variant = WlthyButtonVariant.filled,
    this.onDark = false,
    this.dense = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final WlthyButtonVariant variant;
  final bool onDark;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final Color fg;
    final Color? bg;
    final BorderSide side;

    switch (variant) {
      case WlthyButtonVariant.filled:
        bg = onDark ? AppColors.onDark : AppColors.ink;
        fg = onDark ? AppColors.ink : AppColors.onDark;
        side = BorderSide.none;
      case WlthyButtonVariant.outline:
        bg = null;
        fg = onDark ? AppColors.onDark : AppColors.ink;
        side = BorderSide(
          color: onDark ? AppColors.hairlineOnDark : AppColors.hairline,
        );
      case WlthyButtonVariant.ghost:
        bg = null;
        fg = onDark ? AppColors.onDark : AppColors.ink;
        side = BorderSide.none;
    }

    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        side: side,
        shape: const StadiumBorder(),
        padding: EdgeInsets.symmetric(
          horizontal: dense ? 18 : 26,
          vertical: dense ? 12 : 16,
        ),
        textStyle: FigmaText.button(fg),
      ),
      child: Text(label),
    );
  }
}
