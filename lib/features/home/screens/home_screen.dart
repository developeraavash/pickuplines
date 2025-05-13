import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/widgets/alertbox.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/screens/first_line_screen.dart';
import 'package:pickuplines/features/home/wigets/first_line_card.dart';
import 'package:pickuplines/features/home/wigets/quote_datails_screen.dart';
import 'package:pickuplines/features/pointedcard/screens/pointed_quotes_card.dart';
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
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error loading flirt content: $e');
    }
  }

  Map<String, dynamic>? getRandomFlirtLine() {
    if (flirtLines.isEmpty) return null;

    int randomIndex = _random.nextInt(flirtLines.length);
    return flirtLines[randomIndex] as Map<String, dynamic>;
  }

  // Shuffle the flirt lines for randomness
  List<dynamic> getShuffledFlirtLines() {
    final List<dynamic> shuffledList = List.from(flirtLines);
    shuffledList.shuffle(_random);
    return shuffledList;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: t.firstLine,
        showBackButton: false,
        height: AppSizes.appBarHeightDetail,
        subtitle: t.weHavePickedSomeLineFor,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.only(
                  top: 200,
                  left: 20,
                  right: 20,
                  bottom: 100,
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
                            color: Color(0xFFFF6B9E),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Top Flirt Lines',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        Spacer(),
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
                              color: Color(0xFFFF6B9E),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: AppSizes.scrollableCardSize,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var i = 0; i < 3 && i < flirtLines.length; i++)
                          Padding(
                            padding: EdgeInsets.only(right: i < 2 ? 16 : 0),
                            child: FirstLineCard(
                              category: flirtLines[i]['category'],
                              line: flirtLines[i]['line'],
                              color: _getColorForCategory(
                                flirtLines[i]['category'],
                              ),
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
                            color: Color(0xFF5EAFC0),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(width: 10),
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
                          PointedQuoteCard(
                            title: flirt['line'],
                            author: flirt['category'],
                            color: _getColorForCategory(flirt['category']),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => QuoteDetailScreen(
                                        quote: flirt['line'],
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

          if (randomFlirtLine == null) {
            return;
          }

          showDialog(
            context: context,
            builder: (context) {
              return AlertBox(randomFlirtLine: randomFlirtLine);
            },
          );
        },
        backgroundColor: Color(0xFFFF6B9E),
        child: Icon(Icons.favorite, color: Colors.white),
      ),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'playful':
        return Color(0xFF9E8FFF);
      case 'romantic':
        return Color(0xFFFF6B9E);
      case 'cheeky':
        return Color(0xFFF9BA51);
      case 'intellectual':
        return Color(0xFF5EAFC0);
      case 'situational':
        return Color(0xFF5ED584);
      default:
        return Color(0xFFB57470);
    }
  }
}
