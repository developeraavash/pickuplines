import 'package:flutter/material.dart';
import 'package:pickuplines/core/constants/app_colors.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
 

class AppLogo extends StatelessWidget {
  final double iconSize;
  final double fontSize;

  const AppLogo({super.key, this.iconSize = 80, this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.directions_car_filled, size: iconSize),
        ),
        const SizedBox(height:  AppSizes.md),
        Text(
          'Driving License',
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
