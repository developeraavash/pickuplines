import 'package:flutter/material.dart';
import 'package:pickuplines/core/helpers/THelperFunc.dart';
import 'package:pickuplines/features/navigation/model/navigation_item_data.dart';
import 'package:pickuplines/features/navigation/widgets/navigation_bar_item.dart';

class AnimatedBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  AnimatedBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  // Define navigation items with their colors
  final List<NavigationItemData> items = [
    NavigationItemData(
      icon: Icons.home_rounded,
      label: 'Home',
      activeColor: Color(0xFF5EAFC0),
    ),
    NavigationItemData(
      icon: Icons.favorite_rounded,
      label: 'First Lines',
      activeColor: Color(0xFFFF6B9E),
    ),
    NavigationItemData(
      icon: Icons.bookmark_rounded,
      label: 'Saved',
      activeColor: Color(0xFFE85B48),
    ),
    NavigationItemData(
      icon: Icons.settings_rounded,
      label: 'Settings',
      activeColor: Color(0xFFB57470),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Thelperfunc.isDarkMode(context);
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: Offset(0, -2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            return NavigationBarItem(
              icon: items[index].icon,
              label: items[index].label,
              color: items[index].activeColor,
              isSelected: selectedIndex == index,
              onTap: () => onItemSelected(index),
            );
          }),
        ),
      ),
    );
  }
}
