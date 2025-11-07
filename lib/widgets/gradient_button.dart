import 'dart:ui';

import 'package:assignment_8club/constants/app_colors.dart';
import 'package:assignment_8club/constants/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isClickable;
  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isClickable = true,
  });

  @override
  Widget build(BuildContext context) {
    Color foreground = AppColors.text1.withValues(
      alpha: isClickable ? 1.0 : 0.3,
    );
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          gradient: AppColors.borderGradient.withOpacity(
            isClickable ? 1.0 : 0.3,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(8.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: AppColors.boxGradient,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                spacing: 8.0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.b1.copyWith(
                      color: foreground,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Icon(
                    LucideIcons.arrowBigRightDash,
                    size: 14.0,
                    color: foreground,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
