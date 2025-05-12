import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/widgets/category_chip.dart';
import 'package:pickuplines/features/first_line/widgets/first_line_category_card.dart';
import 'package:pickuplines/l18n/app_localizations.dart';

class GirlsFirstLinesScreen extends StatefulWidget {
  const GirlsFirstLinesScreen({super.key});

  @override
  State<GirlsFirstLinesScreen> createState() => _GirlsFirstLinesScreenState();
}

class _GirlsFirstLinesScreenState extends State<GirlsFirstLinesScreen> {
  List<dynamic> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final String data = await rootBundle.loadString(
      'assets/data/flirt_first_line.json',
    );
    final jsonResult = json.decode(data);
    setState(() {
      categories = jsonResult['categories'];
      isLoading = false;
    });
  }

  IconData _iconFromString(String iconName) {
    switch (iconName) {
      case 'coffee_rounded':
        return Icons.coffee_rounded;
      case 'restaurant_rounded':
        return Icons.restaurant_rounded;
      case 'palette_rounded':
        return Icons.palette_rounded;
      case 'park_rounded':
        return Icons.park_rounded;
      default:
        return Icons.star;
    }
  }

  Color _colorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) hexColor = 'FF$hexColor';
    return Color(int.parse(hexColor, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: t.firstLineForHer,
        height: AppSizes.appBarHeightDetail,
        subtitle: t.conversationStarterThatConnect,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.only(
                  top: AppSizes.appBarHeightDetailPadding,
                  left: 20,
                  right: 20,
                  bottom: 100,
                ),
                children: [
                  // Categories (you can also load these from JSON if you want)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryChip(
                          label: 'Genuine',
                          color: Color(0xFFFF6B9E),
                          isSelected: true,
                        ),
                        CategoryChip(
                          label: 'Playful',
                          color: Color(0xFF9E8FFF),
                          isSelected: false,
                        ),
                        CategoryChip(
                          label: 'Deep',
                          color: Color(0xFF5ED584),
                          isSelected: false,
                        ),
                        CategoryChip(
                          label: 'Funny',
                          color: Color(0xFFF9BA51),
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                  // Dynamically generated cards
                  for (final cat in categories)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FirstLineCategoryCard(
                        title: cat['title'],
                        subtitle: cat['subtitle'],
                        icon: _iconFromString(cat['icon']),
                        color: _colorFromHex(cat['color']),
                        lines: List<String>.from(cat['lines']),
                      ),
                    ),
                ],
              ),
    );
  }
}
