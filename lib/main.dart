import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DailyQuotesApp());
}

class DailyQuotesApp extends StatelessWidget {
  const DailyQuotesApp({Key? key}) : super(key: key);

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
  const HomeScreen({Key? key}) : super(key: key);

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

class GirlsFirstLinesScreen extends StatefulWidget {
  @override
  State<GirlsFirstLinesScreen> createState() => _GirlsFirstLinesScreenState();
}

class _GirlsFirstLinesScreenState extends State<GirlsFirstLinesScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: 'First Lines for Her',
        showBackButton: true,
        height: 130,
        subtitle: 'Conversation starters that connect',
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 150, left: 20, right: 20, bottom: 100),
        children: [
          // Categories
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryChip(
                  label: 'Genuine',
                  color: Color(0xFFFF6B9E),
                  isSelected: true,
                ),
                CategoryChip(
                  label: 'Playful',
                  color: Color(0xFF9E8FFF),
                  isSelected: false,
                ),
                CategoryChip(
                  label: 'Deep',
                  color: Color(0xFF5ED584),
                  isSelected: false,
                ),
                CategoryChip(
                  label: 'Funny',
                  color: Color(0xFFF9BA51),
                  isSelected: false,
                ),
              ],
            ),
          ),

          // First Line Cards
          FirstLineCategoryCard(
            title: "Coffee Shop",
            subtitle: "Casual and comfortable setting",
            icon: Icons.coffee_rounded,
            color: Color(0xFFFF6B9E),
            lines: [
              "I've been trying to decide between trying the lavender latte or the caramel one. Which would you recommend?",
              "I'm curious - what's your go-to coffee order that says something about your personality?",
              "That book you're reading looks interesting. Is it as good as it seems?",
              "I love this café's playlist. Do you have a favorite song that's been on repeat for you lately?",
              "I noticed your [bag/shoes/etc.]. I've been looking for something like that. Where did you find it?",
            ],
          ),
          SizedBox(height: 20),

          FirstLineCategoryCard(
            title: "Dinner Date",
            subtitle: "For a restaurant setting",
            icon: Icons.restaurant_rounded,
            color: Color(0xFF9E8FFF),
            lines: [
              "If you could eat one cuisine for the rest of your life, which would you choose?",
              "What's the most memorable meal you've ever had and what made it special?",
              "I'm always curious about food traditions. Does your family have any special recipes?",
              "Are you more of a 'follow the recipe exactly' or a 'throw in whatever looks good' kind of cook?",
              "What's your comfort food when you've had a long day?",
            ],
          ),
          SizedBox(height: 20),

          FirstLineCategoryCard(
            title: "Art Gallery",
            subtitle: "For the creative connection",
            icon: Icons.palette_rounded,
            color: Color(0xFF5ED584),
            lines: [
              "Which piece here speaks to you most? I'd love to see it through your eyes.",
              "If you could have any artist, past or present, create something for your home, who would you choose?",
              "Do you have a creative outlet that helps you express yourself?",
              "What kind of art did you connect with first as a kid?",
              "I love how art reveals what we're drawn to. What colors or styles do you find yourself gravitating toward?",
            ],
          ),
          SizedBox(height: 20),

          FirstLineCategoryCard(
            title: "Walk in the Park",
            subtitle: "Casual outdoor conversation",
            icon: Icons.park_rounded,
            color: Color(0xFFF9BA51),
            lines: [
              "What's your favorite season and what makes it special for you?",
              "Are you a mountains, beach, or city person at heart?",
              "If you could live anywhere with perfect weather year-round, where would it be?",
              "Do you have a favorite spot in nature that feels like 'your place'?",
              "What outdoor activity makes you feel most alive?",
            ],
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

class CategoryChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;

  const CategoryChip({
    Key? key,
    required this.label,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.transparent : color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
                : [],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : color,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}

class QuoteDetailScreen extends StatefulWidget {
  const QuoteDetailScreen({Key? key}) : super(key: key);

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

class FirstLineCard extends StatelessWidget {
  final String category;
  final String line;
  final Color color;

  const FirstLineCard({
    Key? key,
    required this.category,
    required this.line,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            line,
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
              color: Colors.grey.shade800,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.favorite_border, size: 20, color: color),
              SizedBox(width: 15),
              Icon(Icons.copy_outlined, size: 20, color: color),
            ],
          ),
        ],
      ),
    );
  }
}

class FirstLineCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<String> lines;

  const FirstLineCategoryCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.lines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 20,
            offset: Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Lines List
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FIRST LINES TO TRY',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 16),
                ...List.generate(lines.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chat_bubble_outline,
                            color: color,
                            size: 14,
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lines[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade800,
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    size: 16,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '${24 + index * 7}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Icon(
                                    Icons.copy_outlined,
                                    size: 16,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
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
    Key? key,
    required this.title,
    this.subtitle,
    this.showBackButton = false,
    required this.height,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedBottomClipper(),
      child: Container(
        height: height,
        color: Colors.white,
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
                          style: const TextStyle(
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
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
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
                    backgroundColor: Colors.white.withOpacity(0.2),
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
                    backgroundColor: Colors.white.withOpacity(0.2),
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
      icon: Icons.favorite_rounded,
      label: 'First Lines',
      activeColor: Color(0xFFFF6B9E),
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
            color: Colors.black.withOpacity(0.06),
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
                    isSelected ? color.withOpacity(0.15) : Colors.transparent,
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
