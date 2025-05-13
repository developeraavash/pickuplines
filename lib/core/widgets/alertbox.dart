import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/constants/app_colors.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/helpers/THelperFunc.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({super.key, required this.randomFlirtLine});

  final Map<String, dynamic>? randomFlirtLine;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.md),
      ),
      backgroundColor:
          Thelperfunc.isDarkMode(context)
              ? AppColors.backgroundDark
              : const Color.fromARGB(255, 229, 222, 222),
      title: Row(
        children: [
          Icon(Icons.favorite, color: Color(0xFFFF6B9E), size: AppSizes.md),
          SizedBox(width: 10.h),
          Flexible(
            child: Text(
              randomFlirtLine?['category'],
              style: TextStyle(
                fontSize: AppSizes.lg,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF6B9E),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),

      content: Text(
        randomFlirtLine?['line'],
        style: TextStyle(
          fontSize: AppSizes.md,

          color: Thelperfunc.isDarkMode(context) ? Colors.white : Colors.black,
        ),
        textAlign: TextAlign.justify,
      ),

      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFFFF6B9E),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Close',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
