import 'package:flutter/material.dart';
import 'package:pickuplines/core/helpers/THelperFunc.dart';
 import 'package:pickuplines/features/home/widgets/drawer_items.dart';
import 'package:pickuplines/features/favourite/saved_screen.dart';
import 'package:pickuplines/main_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pickuplines/l18n/app_localizations.dart';
import 'package:pickuplines/flirt_app.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Drawer(
      child: Container(
        color: const Color(0xFFC2185B),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:
                      Thelperfunc.isDarkMode(context)
                          ? [
                            const Color(0xFFC2185B),
                            const Color(0xFFAD1457),
                            const Color(0xFF78002E),
                          ]
                          : [
                            const Color(0xFFF06292),
                            const Color(0xFFD81B60),
                            const Color(0xFFC2185B),
                          ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.appName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    t.appTagline,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            DrawerItem(
              icon: Icons.home,
              title: t.home,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                  (route) => false,
                );
              },
            ),
            DrawerItem(
              icon: Icons.favorite,
              title: t.favorites,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SavedScreen()),
                );
              },
            ),
            DrawerItem(
              icon: Icons.settings,
              title: t.settings,
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => _buildSettingsDialog(context),
                );
              },
            ),
            DrawerItem(
              icon: Icons.star_border,
              title: t.rateFiveStar,
              onTap: () async {
                final Uri url = Uri.parse(
                  'https://play.google.com/store/apps/details?id=com.flirt.lines',
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
            DrawerItem(
              icon: Icons.share,
              title: t.shareApp,
              onTap: () {
                Share.share(
                  '${t.shareMessage}\nhttps://play.google.com/store/apps/details?id=com.flirt.lines',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsDialog(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final provider = LocaleAndThemeProvider.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
      title: Text(t.settings),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dark Mode Toggle
          SwitchListTile(
            title: Text(t.darkMode),
            value: isDark,
            onChanged: (bool value) {
              provider?.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              Navigator.pop(context);
            },
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
          // Language Selection
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(t.language),
            subtitle: Text(
              Localizations.localeOf(context).languageCode == 'es'
                  ? 'Español'
                  : 'English',
            ),
            onTap: () {
              Navigator.pop(context);
              _showLanguageDialog(context);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.close),
        ),
      ],
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final provider = LocaleAndThemeProvider.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            title: Text(t.language),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('English'),
                  leading: const Text('🇺🇸'),
                  onTap: () {
                    provider?.setLocale(const Locale('en'));
                    Navigator.pop(context);
                  },
                  trailing:
                      Localizations.localeOf(context).languageCode == 'en'
                          ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                          : null,
                ),
                ListTile(
                  title: const Text('Español'),
                  leading: const Text('🇪🇸'),
                  onTap: () {
                    provider?.setLocale(const Locale('es'));
                    Navigator.pop(context);
                  },
                  trailing:
                      Localizations.localeOf(context).languageCode == 'es'
                          ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                          : null,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(t.close),
              ),
            ],
          ),
    );
  }
}
