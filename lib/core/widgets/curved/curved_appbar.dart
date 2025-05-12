import 'package:flutter/material.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/helpers/THelperFunc.dart';
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                Thelperfunc.isDarkMode(context)
                    ? [
                      const Color(0xFFC2185B), // Pink 700
                      const Color(0xFFAD1457), // Pink 800
                      const Color(0xFF78002E), // Darker custom burgundy
                    ]
                    : [
                      const Color(0xFFF06292), // Pink 300
                      const Color(0xFFD81B60), // Pink 600
                      const Color(0xFFC2185B), // Pink 700
                    ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),

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
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: AppSizes.md,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                                  color: Colors.white,
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
