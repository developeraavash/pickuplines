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
  List<dynamic> chipCategories = [];
  bool isLoading = true;
  int selectedChipIndex = 0;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final String data = await rootBundle.loadString(
      'assets/data/firstline/flirt_first_line.json',
    );
    final jsonResult = json.decode(data);
    setState(() {
      categories = jsonResult['categories'];
      // Create chip categories from the main categories
      chipCategories =
          categories
              .map((cat) => {'label': cat['title'], 'color': cat['color']})
              .toList();
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
                  // Dynamic category chips
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < chipCategories.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CategoryChip(
                                label: chipCategories[i]['label'],
                                color: _colorFromHex(
                                  chipCategories[i]['color'],
                                ),
                                isSelected: selectedChipIndex == i,
                                onSelected: () {
                                  setState(() {
                                    selectedChipIndex = i;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  // Dynamically generated cards - showing only the selected category
                  FirstLineCategoryCard(
                    title: categories[selectedChipIndex]['title'],
                    subtitle: categories[selectedChipIndex]['subtitle'],
                    icon: _iconFromString(
                      categories[selectedChipIndex]['icon'],
                    ),
                    color: _colorFromHex(
                      categories[selectedChipIndex]['color'],
                    ),
                    lines: List<String>.from(
                      categories[selectedChipIndex]['lines'],
                    ),
                  ),
                ],
              ),
    );
  }
}
