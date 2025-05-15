import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  int selectedChipIndex = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('Initializing GirlsFirstLinesScreen');
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      debugPrint('Loading categories...');
      final String data = await rootBundle.loadString(
        'assets/data/firstline/flirt_first_line.json',
      );
      debugPrint('JSON data loaded successfully');

      final jsonResult = json.decode(data);
      final List<dynamic> categoriesList =
          jsonResult['categories'] as List<dynamic>;
      debugPrint('Found ${categoriesList.length} categories');

      setState(() {
        categories = categoriesList;
        isLoading = false;
        debugPrint('Categories set in state: ${categories.length}');
      });
    } catch (e, stackTrace) {
      debugPrint('Error loading categories: $e');
      debugPrint('Stack trace: $stackTrace');
      setState(() {
        categories = [];
        isLoading = false;
      });
    }
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
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
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
              : categories.isEmpty
              ? Center(child: Text(t.noCategoriesFound))
              : ListView(
                padding: EdgeInsets.only(
                  top: AppSizes.appBarHeightDetailPadding,
                  left: 20,
                  right: 20,
                  bottom: 100,
                ),
                children: [
                  // Category chips
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          categories.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: 8.h),
                            child: CategoryChip(
                              label: categories[index]['title'],
                              color: _colorFromHex(categories[index]['color']),
                              isSelected: selectedChipIndex == index,
                              onSelected: () {
                                setState(() {
                                  selectedChipIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Selected category card
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

class FirstLineScreen extends StatefulWidget {
  @override
  _FirstLineScreenState createState() => _FirstLineScreenState();
}

class _FirstLineScreenState extends State<FirstLineScreen> {
  List categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final String data = await rootBundle.loadString(
        'assets/data/firstline/flirt_first_line.json',
      );
      debugPrint('Loaded JSON data: $data');

      final jsonResult = json.decode(data);
      debugPrint('Decoded JSON result: $jsonResult');

      if (jsonResult['categories'] == null) {
        debugPrint('Error: No categories found in JSON');
        setState(() {
          categories = [];
          isLoading = false;
        });
        return;
      }

      setState(() {
        categories = jsonResult['categories'];
        debugPrint('Categories loaded: ${categories.length}');
        isLoading = false;
      });
    } catch (e, stackTrace) {
      debugPrint('Error loading categories: $e');
      debugPrint('Stack trace: $stackTrace');
      setState(() {
        categories = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          title: Text(category['title']),
          subtitle: Text(category['subtitle']),
        );
      },
    );
  }
}
