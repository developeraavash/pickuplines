import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onSelected;

  const CategoryChip({
    super.key,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipColor =
        isSelected ? color : (isDark ? Colors.grey[800] : Colors.white);
    final textColor = isSelected ? Colors.white : color;

    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: color.withValues(alpha: isSelected ? 0 : 0.3),
            width: 1.5,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
