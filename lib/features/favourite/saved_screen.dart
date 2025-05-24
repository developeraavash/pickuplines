import 'package:flutter/material.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/features/favourite/controller/favorites_controller.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/widgets/category_chip.dart';
import 'package:pickuplines/features/first_line/widgets/first_line_category_card.dart';
import 'package:pickuplines/l18n/app_localizations.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load saved lines when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesController>().loadSavedLines();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final favoritesController = context.watch<FavoritesController>();
    final isLoading = favoritesController.isLoading;
    final savedLines = favoritesController.getCurrentCategoryLines();
    final chipCategories = favoritesController.chipCategories;

    return Scaffold(
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
                  // top: AppSizes.appBarHeightDetailPadding,
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
                                isSelected:
                                    favoritesController.selectedChipIndex ==
                                    index,
                                onSelected: () {
                                  favoritesController.setSelectedChipIndex(
                                    index,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    // Saved lines with proper constraints
                    ...savedLines.map((line) {
                      return Container(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth - 32, // Account for padding
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: FirstLineCategoryCard(
                          lineAvailable: false,
                          title: line['line'],
                          subtitle: line['category'],
                          icon: _getCategoryIcon(line['category']),
                          color: _getCategoryColor(line['category']),
                          lines: [],
                          onDelete: () async {
                            await favoritesController.removeFavorite(
                              line['id'],
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'playful':
        return Icons.celebration;
      case 'romantic':
        return Icons.favorite;
      case 'cheeky':
        return Icons.emoji_emotions;
      case 'intellectual':
        return Icons.psychology;
      case 'situational':
        return Icons.electric_bolt;
      default:
        return Icons.star;
    }
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
}
