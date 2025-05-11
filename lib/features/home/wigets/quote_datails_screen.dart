import 'package:flutter/material.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/pointedcard/screens/pointed_quotes_card.dart';
import 'package:pickuplines/features/pointedcard/screens/pointed_quotes_card_details.dart';

import '../../navigation/screens/animatedBottom_bar.dart';

class QuoteDetailScreen extends StatefulWidget {
  const QuoteDetailScreen({super.key});

  @override
  State<QuoteDetailScreen> createState() => _QuoteDetailScreenState();
}

class _QuoteDetailScreenState extends State<QuoteDetailScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: 'A Man Called Otto',
        height: 120,
        subtitle: 'Movie',
        showBackButton: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 140, left: 20, right: 20, bottom: 100),
        children: [
          PointedQuoteCard(
            title: 'Pursuit of Happiness',
            author: 'Movie',
            color: const Color(0xFFF9BA51),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          PointedQuoteDetailCard(
            title: 'Shoe Dog',
            author: 'Book',
            color: const Color(0xFFE85B48),
            quote:
                'Don\'t tell people how to do things, tell them what to do and let them surprise you with their results.',
          ),
          const SizedBox(height: 16),
          PointedQuoteCard(
            title: 'Show and Tell',
            author: 'Movie',
            color: const Color(0xFFB57470),
            onTap: () {},
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
}
