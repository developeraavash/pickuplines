import 'package:flutter/material.dart';
import 'package:pickuplines/core/constants/app_colors.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/widgets/curved/bottom_clipper.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final double height;

  const CurvedAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = false,
    required this.height,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedBottomClipper(),
      child: Container(
        height: height,
        color:AppColors.accent,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showBackButton
                    ? Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: AppColors.textWhite,
                          ),
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textWhite,
                          ),
                        ),
                      ],
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 10),
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.textWhite,
                            fontSize: AppSizes.lg,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                if (subtitle != null)
                  Padding(
                    padding: EdgeInsets.only(
                      left: showBackButton ? 30 : 0,
                      top: 5,
                    ),
                    child: Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
