import 'package:flutter/material.dart';

void main() {
  runApp(const DailyQuotesApp());
}

class DailyQuotesApp extends StatelessWidget {
  const DailyQuotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Quotes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildCurvedAppBar(
            title: 'Daily\nQuotes',
            subtitle: 'We\'ve picked some quotes for You',
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
              ],
            ),
          ),
          CustomBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildCurvedAppBar({required String title, required String subtitle}) {
    return ClipPath(
      clipper: CurvedBottomClipper(),
      child: Container(
        height: 200,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class QuoteDetailScreen extends StatelessWidget {
  const QuoteDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildCurvedAppBar(title: 'A Man Called Otto', subtitle: 'Movie'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
              ],
            ),
          ),
          CustomBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildCurvedAppBar({required String title, required String subtitle}) {
    return ClipPath(
      clipper: CurvedBottomClipper(),
      child: Container(
        height: 130,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 10);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 20);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class PointedQuoteCard extends StatelessWidget {
  final String title;
  final String author;
  final Color color;
  final VoidCallback? onTap;

  const PointedQuoteCard({
    Key? key,
    required this.title,
    required this.author,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: PointedCardPainter(color: color),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    author,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              const Icon(Icons.more_horiz, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class PointedQuoteDetailCard extends StatelessWidget {
  final String title;
  final String author;
  final Color color;
  final String quote;

  const PointedQuoteDetailCard({
    Key? key,
    required this.title,
    required this.author,
    required this.color,
    required this.quote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PointedCardPainter(color: color),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      author,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.more_horiz, color: Colors.white),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              '"$quote"',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha:0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'ARTICLE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha:0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'LEADERSHIP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PointedCardPainter extends CustomPainter {
  final Color color;

  PointedCardPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // Start at top-left
    path.moveTo(0, 8);

    // Top-left rounded corner
    path.quadraticBezierTo(0, 0, 8, 0);

    // Top edge
    path.lineTo(size.width - 20, 0);

    // Pointed top-right corner
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);

    // Bottom edge
    path.lineTo(8, size.height);

    // Bottom-left rounded corner
    path.quadraticBezierTo(0, size.height, 0, size.height - 8);

    // Left edge
    path.lineTo(0, 8);

    // Fill the path
    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavItem(
            icon: Icons.home_filled,
            label: 'Home',
            isSelected: true,
          ),
          BottomNavItem(icon: Icons.search, label: 'Search', isSelected: false),
          BottomNavItem(
            icon: Icons.bookmark_border,
            label: 'Saved',
            isSelected: false,
          ),
          BottomNavItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            isSelected: false,
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isSelected ? Colors.black : Colors.grey, size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
