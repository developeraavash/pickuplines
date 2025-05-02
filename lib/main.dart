import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DailyQuotesApp());
}

class DailyQuotesApp extends StatelessWidget {
  const DailyQuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Quotes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

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
        height: 180,
        subtitle: 'We\'ve picked some quotes for You',
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 200, left: 20, right: 20),
        children: [
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
          const SizedBox(height: 100), // Bottom padding for navigation bar
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
        padding: EdgeInsets.only(top: 140, left: 20, right: 20),
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
          const SizedBox(height: 100), // Bottom padding for navigation bar
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

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final double height;

  const CurvedAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = false,
    required this.height,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedBottomClipper(),
      child: Container(
        height: height,
        color: Colors.red,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showBackButton
                    ? Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, size: 20),
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                if (subtitle != null)
                  Padding(
                    padding: EdgeInsets.only(
                      left: showBackButton ? 30 : 0,
                      top: 5,
                    ),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
              ],
            ),
          ),
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
    var firstEndPoint = Offset(size.width / 2, size.height - 15);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 30);
    var secondEndPoint = Offset(size.width, size.height - 15);
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
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
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
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
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

class AnimatedBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  AnimatedBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  // Define navigation items with their colors
  final List<NavigationItemData> items = [
    NavigationItemData(
      icon: Icons.home_rounded,
      label: 'Home',
      activeColor: Color(0xFF5EAFC0),
    ),
    NavigationItemData(
      icon: Icons.search_rounded,
      label: 'Discover',
      activeColor: Color(0xFFF9BA51),
    ),
    NavigationItemData(
      icon: Icons.bookmark_rounded,
      label: 'Saved',
      activeColor: Color(0xFFE85B48),
    ),
    NavigationItemData(
      icon: Icons.settings_rounded,
      label: 'Settings',
      activeColor: Color(0xFFB57470),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: Offset(0, -2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            return NavigationBarItem(
              icon: items[index].icon,
              label: items[index].label,
              color: items[index].activeColor,
              isSelected: selectedIndex == index,
              onTap: () => onItemSelected(index),
            );
          }),
        ),
      ),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationBarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated container for the icon background
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: isSelected ? 40 : 36,
              width: isSelected ? 40 : 36,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? color.withValues(alpha: 0.15)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isSelected ? color : Colors.grey.shade400,
                size: isSelected ? 24 : 22,
              ),
            ),
            const SizedBox(height: 4),
            // Animated text
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? color : Colors.grey.shade500,
                fontSize: isSelected ? 12 : 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                letterSpacing: isSelected ? 0.2 : 0,
              ),
              child: Text(label),
            ),
            // Animated indicator dot
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 4,
              width: isSelected ? 20 : 0,
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItemData {
  final IconData icon;
  final String label;
  final Color activeColor;

  NavigationItemData({
    required this.icon,
    required this.label,
    required this.activeColor,
  });
}
