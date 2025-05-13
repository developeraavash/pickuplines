import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/constants/app_colors.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/helpers/THelperFunc.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality

class AlertBox extends StatelessWidget {
  const AlertBox({super.key, required this.randomFlirtLine});

  final Map<String, dynamic>? randomFlirtLine;

  // Method to copy text to clipboard
  void _copyToClipboard(BuildContext context) {
    if (randomFlirtLine?['line'] != null) {
      Clipboard.setData(ClipboardData(text: randomFlirtLine!['line']));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied to clipboard!'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.favorite, color: Color(0xFFFF6B9E), size: AppSizes.lg),
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
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.copy, color: Color(0xFFFF6B9E)),
              onPressed: () => _copyToClipboard(context),
              tooltip: 'Copy to clipboard',
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            randomFlirtLine?['line'],
            style: TextStyle(
              fontSize: AppSizes.md,
              color:
                  Thelperfunc.isDarkMode(context) ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 16.h),
        ],
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
