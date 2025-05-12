import 'package:flutter/material.dart';
import 'package:pickuplines/core/constants/app_colors.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/widgets/curved/bottom_clipper.dart';
import 'package:pickuplines/main.dart';

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
        color: AppColors.accent,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title and subtitle
                Expanded(
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
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: AppSizes.md,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textWhite,
                                ),
                              ),
                            ],
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                // Theme switcher
                IconButton(
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: Colors.white,
                  ),
                  tooltip: 'Toggle Theme',
                  onPressed: () {
                    final provider = LocaleAndThemeProvider.of(context);
                    if (provider != null) {
                      provider.setThemeMode(
                        provider.themeMode == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark,
                      );
                    }
                  },
                ),
                // Language selector
                PopupMenuButton<Locale>(
                  icon: const Icon(Icons.language, color: Colors.white),
                  onSelected: (locale) {
                    LocaleAndThemeProvider.of(context)?.setLocale(locale);
                  },
                  itemBuilder:
                      (context) => const [
                        PopupMenuItem(
                          value: Locale('en'),
                          child: Text('English'),
                        ),
                        PopupMenuItem(
                          value: Locale('es'),
                          child: Text('Español'),
                        ),
                      ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
