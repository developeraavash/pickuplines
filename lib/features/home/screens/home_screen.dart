import 'package:flutter/material.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/screens/first_line.dart';
import 'package:pickuplines/features/home/wigets/first_line_card.dart';
import 'package:pickuplines/features/home/wigets/quote_datails_screen.dart';
import 'package:pickuplines/features/navigation/screens/animatedBottom_bar.dart';
import 'package:pickuplines/features/pointedcard/screens/pointed_quotes_card.dart';
import 'package:pickuplines/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: 'Daily Quotes',
        showBackButton: false,
        height: 170,
        subtitle: 'We\'ve picked some quotes for You',
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 200, left: 20, right: 20, bottom: 100),
        children: [
          // First Date with Girls Section Header
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
                  'First Date with Her',
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

          // First Lines Horizontal Scroll
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FirstLineCard(
                  category: "Genuine",
                  line:
                      "I noticed you like [something you observed]. What got you interested in that?",
                  color: Color(0xFFFF6B9E),
                ),
                SizedBox(width: 16),
                FirstLineCard(
                  category: "Playful",
                  line: "If your life was a movie, what would the title be?",
                  color: Color(0xFF9E8FFF),
                ),
                SizedBox(width: 16),
                FirstLineCard(
                  category: "Thoughtful",
                  line:
                      "What's something small that always makes your day better?",
                  color: Color(0xFF5ED584),
                ),
              ],
            ),
          ),

          // Regular Quotes Header
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
                  'Inspiring Quotes',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),

          // Regular quotes list
          PointedQuoteCard(
            title: 'A Man Called Otto',
            author: 'Movie',
            color: const Color(0xFF5EAFC0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuoteDetailScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          PointedQuoteCard(
            title: 'Pursuit of Happiness',
            author: 'Movie',
            color: const Color(0xFFF9BA51),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          PointedQuoteCard(
            title: 'Shoe Dog',
            author: 'Book',
            color: const Color(0xFFE85B48),
            onTap: () {},
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
}
