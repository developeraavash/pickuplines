import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';

class FirstLineCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool lineAvailable;
  final IconData icon;
  final Color color;
  final List<String> lines;
  final VoidCallback? onDelete;

  const FirstLineCategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.lines,
    this.onDelete,
    this.lineAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24.r),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSizes.md,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: AppSizes.sm,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Lines

          // ! quotes
          if (lineAvailable && lines.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    lines
                        .map(
                          (line) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  color: color,
                                  size: 20.r,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    line,
                                    style: TextStyle(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                      fontSize: AppSizes.md / 1.2,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
