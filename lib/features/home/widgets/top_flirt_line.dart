import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/constants/app_colors.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/helpers/THelperFunc.dart';

class TopFlirtLines extends StatefulWidget {
  final String category;
  final String line;
  final Color color;
  final VoidCallback? onCopy;
  final VoidCallback? onFavorite;

  const TopFlirtLines({
    super.key,
    required this.category,
    required this.line,
    required this.color,
    this.onCopy,
    this.onFavorite,
  });

  @override
  State<TopFlirtLines> createState() => _TopFlirtLinesState();
}

class _TopFlirtLinesState extends State<TopFlirtLines>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        _controller.forward(from: 0);
      }
    });
    widget.onFavorite?.call();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Thelperfunc.isDarkMode(context);
    return Container(
      height: 250.h,
      width: 250.w,
      padding: EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: widget.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.md),
        border: Border.all(
          color: widget.color.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.sm,
                    // vertical: AppSizes.sm / 2,
                  ),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppSizes.md),
                  ),
                  child: Text(
                    widget.category,
                    style: TextStyle(
                      color: widget.color,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.sm,
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.sm / 2),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      widget.line,
                      style: TextStyle(
                        fontSize: AppSizes.fontSizeSmall,
                        height: 1.2,
                        color:
                            isDarkMode
                                ? AppColors.textWhite
                                : Colors.grey.shade800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.sizeboxsm),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: AppSizes.iconSize,
                    color: isFavorite ? widget.color : widget.color,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.copy_outlined,
                  size: AppSizes.iconSize,
                  color: widget.color,
                ),
                onPressed: widget.onCopy,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
