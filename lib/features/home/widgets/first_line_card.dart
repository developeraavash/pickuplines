import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/constants/app_colors.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/helpers/THelperFunc.dart';

class TopFlirtLines extends StatelessWidget {
  final String category;
  final String line;
  final Color color;

  const TopFlirtLines({
    super.key,
    required this.category,
    required this.line,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Thelperfunc.isDarkMode(context);
    return Container(
      width: 280.h,
      padding: EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.md),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.sm,
              vertical: AppSizes.sm / 2,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSizes.md),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.sm,
              ),
            ),
          ),
          SizedBox(height: AppSizes.sm / 2),
          Text(
            line,
            style: TextStyle(
              fontSize: AppSizes.fontSizeSmall,
              height: 1.4,
              color: isDarkMode ? AppColors.textWhite : Colors.grey.shade800,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.favorite_border,
                size: AppSizes.iconSize,
                color: color,
              ),
              SizedBox(width: AppSizes.sizeboxno),
              Icon(Icons.copy_outlined, size: AppSizes.iconSize, color: color),
            ],
          ),
        ],
      ),
    );
  }
}
