import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/pointedcard/screens/pointed_quotes_card.dart';
import 'package:pickuplines/features/pointedcard/screens/pointed_flirt_card_details.dart';
import 'package:pickuplines/features/navigation/screens/animatedBottom_bar.dart';

class QuoteDetailScreen extends StatefulWidget {
  final String quote;
  final String author;
  final Color color;
  final List<String>? tags;

  const QuoteDetailScreen({
    super.key,
    required this.quote,
    required this.author,
    required this.color,
    this.tags,
  });

  @override
  State<QuoteDetailScreen> createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {
  int _selectedIndex = 0;
  List<dynamic> relatedQuotes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRelatedQuotes();
  }

  Future<void> _loadRelatedQuotes() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/flirt_data.json',
      );
      final data = await json.decode(response);

      // Filter quotes with the same category or tags
      final allQuotes = [
        ...data['flirt_content']['playful'],
        ...data['flirt_content']['romantic'],
        ...data['flirt_content']['cheeky'],
        ...data['flirt_content']['intellectual'],
        ...data['flirt_content']['situational'],
      ];

      setState(() {
        relatedQuotes =
            allQuotes
                .where(
                  (quote) =>
                      quote['category'] == widget.author.toLowerCase() ||
                      (widget.tags != null &&
                          (quote['tags'] as List).any(
                            (tag) => widget.tags!.contains(tag),
                          )),
                )
                .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading related quotes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title:
            widget.quote.length > 20
                ? '${widget.quote.substring(0, 20)}...'
                : widget.quote,
        height: AppSizes.appBarHeightDetail,
        subtitle: widget.author,
        showBackButton: true,
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
                  // Main quote display
                  PointedFlirtDetailCard(
                    title: widget.quote,
                    author: widget.author,
                    color: widget.color,
                    quote: widget.quote,
                  ),
                  const SizedBox(height: 24),

                  // Related quotes header
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 5,
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'More ${widget.author} Lines',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Related quotes list
                  if (relatedQuotes.isNotEmpty)
                    ...relatedQuotes.map(
                      (quote) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PointedQuoteCard(
                          title: quote['line'],
                          author: quote['category'],
                          color: _getColorForCategory(quote['category']),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => QuoteDetailScreen(
                                      quote: quote['line'],
                                      author: quote['category'],
                                      color: _getColorForCategory(
                                        quote['category'],
                                      ),
                                      tags: List<String>.from(quote['tags']),
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'No related quotes found',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
