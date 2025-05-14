import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/helpers/THelperFunc.dart';
import 'package:pickuplines/core/utils/services/favorite_ser.dart';
import 'package:pickuplines/core/widgets/alertbox.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/screens/first_line_screen.dart';
import 'package:pickuplines/features/home/widgets/drawer_items.dart';
import 'package:pickuplines/features/home/widgets/top_flirt_line.dart';
import 'package:pickuplines/features/home/widgets/flirt_details_screen.dart';
import 'package:pickuplines/features/home/widgets/pointed_quotes_card.dart';
import 'package:pickuplines/features/home/data/flirt_categories.dart';
import 'package:pickuplines/l18n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> flirtLines = [];
  bool isLoading = true;
  final Random _random = Random();
  List<dynamic> topCategoryLines = []; // New list for top category lines

  @override
  void initState() {
    super.initState();
    loadFlirtContent();
  }

  Future<void> loadFlirtContent() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/home/flirt_data.json',
      );
      final data = await json.decode(response);

      setState(() {
        flirtLines = [
          for (final category in flirtCategories)
            ...data['flirt_content'][category],
        ];

        // Get one random line from each category for the top section
        topCategoryLines = _getTopCategoryLines(data['flirt_content']);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error loading flirt content: $e');
    }
  }

  // New method to get one random line from each category
  List<dynamic> _getTopCategoryLines(Map<String, dynamic> flirtContent) {
    List<dynamic> result = [];
    for (final category in flirtCategories) {
      if (flirtContent[category] != null && flirtContent[category].isNotEmpty) {
        final randomIndex = _random.nextInt(flirtContent[category].length);
        result.add(flirtContent[category][randomIndex]);
      }
    }
    // Shuffle to randomize the order
    result.shuffle(_random);
    return result;
  }

  Map<String, dynamic>? getRandomFlirtLine() {
    if (flirtLines.isEmpty) return null;
    int randomIndex = _random.nextInt(flirtLines.length);
    return flirtLines[randomIndex] as Map<String, dynamic>;
  }

  List<dynamic> getShuffledFlirtLines() {
    final List<dynamic> shuffledList = List.from(flirtLines);
    shuffledList.shuffle(_random);
    return shuffledList;
  }

  // Add this method for copying to clipboard
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Copied to clipboard')));
    });
  }

  void _saveToFavorites(Map<String, dynamic> flirtLine) async {
    try {
      await FavoritesService.saveLine(flirtLine);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Added to favorites')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: t.firstLine,
        showBackButton: false,
        showMenuButton: true, // <-- Add this
        height: AppSizes.appBarHeightDetail,
        subtitle: t.weHavePickedSomeLineFor,
      ),
      drawer: AppDrawer(),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.only(
                  top: 150.h,
                  left: 20.h,
                  right: 20.h,
                  bottom: 100.h,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 5,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B9E),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          t.topFlirtLines,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GirlsFirstLinesScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: const Color(0xFFFF6B9E),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //! Updated top flirt lines section
                  SizedBox(
                    height: AppSizes.scrollableCardSize,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var i = 0; i < topCategoryLines.length; i++)
                          Padding(
                            padding: EdgeInsets.only(
                              right: i < topCategoryLines.length - 1 ? 16 : 0,
                            ),
                            child: TopFlirtLines(
                              category: topCategoryLines[i]['category'],
                              line: topCategoryLines[i]['line'],
                              color: _getColorForCategory(
                                topCategoryLines[i]['category'],
                              ),
                              onCopy:
                                  () => _copyToClipboard(
                                    topCategoryLines[i]['line'],
                                  ),
                              onFavorite:
                                  () => _saveToFavorites(topCategoryLines[i]),
                            ),
                          ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 5,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5EAFC0),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'More Flirt Lines',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: flirtLines.length,
                    itemBuilder: (context, index) {
                      final flirt = flirtLines[index];
                      return Column(
                        children: [
                          PointedFlirtCard(
                            title: flirt['line'],
                            author: flirt['category'],
                            color: _getColorForCategory(flirt['category']),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => FlirtDetailScreen(
                                        flirt: flirt['line'],
                                        author: flirt['category'],
                                        tags: List<String>.from(flirt['tags']),
                                        color: _getColorForCategory(
                                          flirt['category'],
                                        ),
                                      ),
                                ),
                              );
                            },
                          ),
                          if (index < flirtLines.length - 1)
                            const SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ],
              ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final randomFlirtLine = getRandomFlirtLine();
          if (randomFlirtLine == null) return;

          showDialog(
            context: context,
            builder: (context) {
              return AlertBox(randomFlirtLine: randomFlirtLine);
            },
          );
        },
        backgroundColor: const Color(0xFFFF6B9E),
        child: const Icon(Icons.favorite, color: Colors.white),
      ),
    );
  }

  Color _getColorForCategory(String category) {
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

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFC2185B), // Set your desired background color
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
                    'Pickup Lines',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find the perfect line for any situation',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            DrawerItem(
              icon: Icons.home,
              title: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            DrawerItem(
              icon: Icons.favorite,
              title: 'Favorites',
              onTap: () {
                // Navigate to favorites screen
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              icon: Icons.star_border,
              title: 'Rate 5 Star',
              onTap: () {},
            ),
            DrawerItem(icon: Icons.share, title: 'Share App', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
