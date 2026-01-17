/// Feature Card Widget
/// 
/// Reusable card for displaying app features on home screen

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        gradient: LinearGradient(
          colors: isDark
              ? [
                  color.withOpacity(0.15),
                  color.withOpacity(0.05),
                ]
              : [
                  color.withOpacity(0.08),
                  color.withOpacity(0.02),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          splashColor: color.withOpacity(0.1),
          highlightColor: color.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.paddingLG),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
              border: Border.all(
                color: color.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Icon with gradient background
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color,
                        color.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.textLight,
                    size: AppDimensions.iconLG,
                  ),
                )
                    .animate()
                    .scale(duration: 300.ms, curve: Curves.easeOut),
                const SizedBox(width: AppDimensions.paddingLG),
                
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.h5.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textLight : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXS),
                      Text(
                        description,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                // Arrow Icon with animation
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: color,
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .moveX(begin: 0, end: 3, duration: 800.ms, curve: Curves.easeInOut),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
