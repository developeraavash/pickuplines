import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/screens/first_line.dart';
import 'package:pickuplines/features/home/wigets/first_line_card.dart';
import 'package:pickuplines/features/home/wigets/quote_datails_screen.dart';
import 'package:pickuplines/features/navigation/screens/animatedBottom_bar.dart';
import 'package:pickuplines/features/pointedcard/screens/pointed_quotes_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<dynamic> flirtLines = [];
  bool isLoading = true;

  final List<Widget> _screens = [
    HomeScreen(),
    GirlsFirstLinesScreen(), // <-- Your First Lines screen
    GirlsFirstLinesScreen(), // <-- Your First Lines screen
    GirlsFirstLinesScreen(), // <-- Your First Lines screen
    // SavedScreen(),
    // SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    loadFlirtContent();
  }

  Future<void> loadFlirtContent() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/flirt_data.json',
      );
      final data = await json.decode(response);
      setState(() {
        // Combine all flirt lines from different categories
        flirtLines = [
          ...data['flirt_content']['playful'],
          ...data['flirt_content']['romantic'],
          ...data['flirt_content']['cheeky'],
          ...data['flirt_content']['intellectual'],
          ...data['flirt_content']['situational'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: 'Flirt Lines',
        showBackButton: false,
        height: 170,
        subtitle: 'We\'ve picked some lines for You',
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
                  // Flirt Lines Section Header
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
                            color: Color(0xFF333333),
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

                  // Flirt Lines Horizontal Scroll
                  SizedBox(
                    height: 140,
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

                  // All Flirt Lines Header
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 16),
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
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // All flirt lines list
                  for (var i = 3; i < flirtLines.length; i++)
                    Column(
                      children: [
                        PointedQuoteCard(
                          title: flirtLines[i]['line'],
                          author: flirtLines[i]['category'],
                          color: _getColorForCategory(
                            flirtLines[i]['category'],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => QuoteDetailScreen(
                                      quote: flirtLines[i]['line'],
                                      author: flirtLines[i]['category'],
                                      tags: List<String>.from(
                                        flirtLines[i]['tags'],
                                      ),
                                      color: _getColorForCategory(
                                        flirtLines[i]['category'],
                                      ),
                                    ),
                              ),
                            );
                          },
                        ),
                        if (i < flirtLines.length - 1)
                          const SizedBox(height: 16),
                      ],
                    ),
                ],
              ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GirlsFirstLinesScreen()),
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
