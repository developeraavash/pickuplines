import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/home/widgets/pointed_quotes_card.dart';
import 'package:pickuplines/features/home/widgets/pointed_flirt_card_details.dart';
import 'package:pickuplines/features/navigation/screens/animatedBottom_bar.dart';

class FlirtDetailScreen extends StatefulWidget {
  final String flirt;
  final String author;
  final Color color;
  final List<String>? tags;

  const FlirtDetailScreen({
    super.key,
    required this.flirt,
    required this.author,
    required this.color,
    this.tags,
  });

  @override
  State<FlirtDetailScreen> createState() => _FlirtDetailScreenState();
}

class _FlirtDetailScreenState extends State<FlirtDetailScreen> {
  int _selectedIndex = 0;
  List<dynamic> relatedFlirts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRelatedFlirts();
  }

  Future<void> _loadRelatedFlirts() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/flirt_data.json',
      );
      final data = await json.decode(response);

      // Filter flirts with the same category or tags
      final allFlirts = [
        ...data['flirt_content']['playful'],
        ...data['flirt_content']['romantic'],
        ...data['flirt_content']['cheeky'],
        ...data['flirt_content']['intellectual'],
        ...data['flirt_content']['situational'],
      ];

      setState(() {
        relatedFlirts =
            allFlirts
                .where(
                  (flirt) =>
                      // Match by category (not author)
                      flirt['category'].toString().toLowerCase() ==
                          widget.author.toLowerCase() &&
                      // Exclude the current flirt itself
                      flirt['line'] != widget.flirt,
                  // Optionally, also match by tags if you want:
                  // || (widget.tags != null &&
                  //     (flirt['tags'] as List).any(
                  //       (tag) => widget.tags!.contains(tag.toString()),
                  //     ))
                )
                .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('Error loading related flirts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title:
            widget.flirt.length > 20
                ? '${widget.flirt.substring(0, 20)}...'
                : widget.flirt,
        height: AppSizes.appBarHeightDetail,
        subtitle: widget.author,
        showBackButton: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: AppSizes.appBarHeightDetailPadding,
                  left: 20,
                  right: 20,
                  bottom: 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main flirt display
                    PointedFlirtDetailCard(
                      title: widget.flirt,
                      author: widget.author,
                      color: widget.color,
                      quote: widget.flirt,
                    ),
                    const SizedBox(height: 24),

                    // Related quotes section
                    _buildRelatedFlirtsSection(),
                  ],
                ),
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

  Widget _buildRelatedFlirtsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              const SizedBox(width: 10),
              Text(
                'More ${widget.author} Lines',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),

        // Related flirts list
        if (relatedFlirts.isNotEmpty)
          ...relatedFlirts.map(
            (flirt) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PointedFlirtCard(
                title: flirt['line'],
                author: flirt['category'],
                color: _getColorForCategory(flirt['category']),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => FlirtDetailScreen(
                            flirt: flirt['line'],
                            author: flirt['category'],
                            color: _getColorForCategory(flirt['category']),
                            tags: List<String>.from(flirt['tags'] ?? []),
                          ),
                    ),
                  );
                },
              ),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'No related flirt found',
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
      ],
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
