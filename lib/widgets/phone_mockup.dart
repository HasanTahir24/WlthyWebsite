import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Placeholder for the app-screenshot phone that appears in the hero and a few
/// other sections. Replace the inner content with the exported Figma asset once
/// image assets are wired into `pubspec.yaml`.
class PhoneMockup extends StatelessWidget {
  const PhoneMockup({super.key, this.width = 300});

  final double width;

  @override
  Widget build(BuildContext context) {
    final height = width * 2.05;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.footer,
        borderRadius: BorderRadius.circular(width * 0.12),
        border: Border.all(color: Colors.black, width: width * 0.02),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 40,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 12, color: AppColors.accent),
                const SizedBox(width: 6),
                Text('wlthy',
                    style: TextStyle(
                        color: AppColors.onDark,
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(height: width * 0.1),
          Center(
            child: Container(
              width: width * 0.5,
              height: width * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accent, width: 8),
              ),
              alignment: Alignment.center,
              child: Text('\$500',
                  style: TextStyle(
                      color: AppColors.onDark,
                      fontSize: width * 0.08,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(height: width * 0.1),
          for (var i = 0; i < 3; i++)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08, vertical: width * 0.02),
              child: Container(
                height: width * 0.16,
                decoration: BoxDecoration(
                  color: AppColors.cardOnDark,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
