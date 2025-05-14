import 'package:flutter/material.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/utils/services/favorite_ser.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/widgets/category_chip.dart';
import 'package:pickuplines/features/first_line/widgets/first_line_category_card.dart';
import 'package:pickuplines/l18n/app_localizations.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Map<String, dynamic>> savedLines = [];
  List<Map<String, dynamic>> chipCategories = [];
  bool isLoading = true;
  int selectedChipIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadSavedLines();
  }

  Future<void> _loadSavedLines() async {
    final lines = await FavoritesService.getSavedLines();

    // Create categories from saved lines
    final Map<String, List<Map<String, dynamic>>> categorized = {};
    for (var line in lines) {
      final category = line['category'];
      if (!categorized.containsKey(category)) {
        categorized[category] = [];
      }
      categorized[category]!.add(line);
    }

    // Create chip categories
    final List<Map<String, dynamic>> chips = [];
    categorized.forEach((category, lines) {
      chips.add({'label': category, 'color': _getCategoryColor(category)});
    });

    setState(() {
      savedLines = lines;
      chipCategories = chips;
      isLoading = false;
    });
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'playful':
        return const Color(0xFF9E8FFF);
      case 'romantic':
        return const Color(0xFFFF6B9E);
      case 'cheeky':
        return const Color(0xFFF9BA51);
      case 'intellectual':
        return const Color(0xFF5EAFC0);
      case 'situational':
        return const Color(0xFF5ED584);
      default:
        return const Color(0xFFB57470);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'playful':
        return Icons.mood;
      case 'romantic':
        return Icons.favorite;
      case 'cheeky':
        return Icons.face;
      case 'intellectual':
        return Icons.lightbulb;
      case 'situational':
        return Icons.location_on;
      default:
        return Icons.star;
    }
  }

  List<Map<String, dynamic>> _getCurrentCategoryLines() {
    if (chipCategories.isEmpty) return [];
    final currentCategory = chipCategories[selectedChipIndex]['label'];
    return savedLines
        .where((line) => line['category'] == currentCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final chipWidth =
        screenWidth * 0.3; // Adjust chip width based on screen size

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: t.savedLines,
        height: AppSizes.appBarHeightDetail,
        subtitle: t.yourFavoritePickupLines,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : savedLines.isEmpty
              ? Center(child: Text(t.noSavedLinesYet))
              : SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: AppSizes.appBarHeightDetailPadding,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    // Category chips with constrained width
                    if (chipCategories.length > 1)
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: chipCategories.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: CategoryChip(
                                label: chipCategories[index]['label'],
                                color: chipCategories[index]['color'],
                                isSelected: selectedChipIndex == index,
                                onSelected: () {
                                  setState(() {
                                    selectedChipIndex = index;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    // Saved lines with proper constraints
                    ..._getCurrentCategoryLines().map((line) {
                      return Container(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth - 32, // Account for padding
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: FirstLineCategoryCard(
                          title: line['line'],
                          subtitle: line['category'],
                          icon: _getCategoryIcon(line['category']),
                          color: _getCategoryColor(line['category']),
                          lines: [],
                          onDelete: () async {
                            await FavoritesService.removeLine(
                              line['id'].toString(),
                            );
                            _loadSavedLines();
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
    );
  }
}
