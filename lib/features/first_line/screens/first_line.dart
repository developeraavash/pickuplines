import 'package:flutter/material.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
 import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/widgets/category_chip.dart';
import 'package:pickuplines/features/first_line/widgets/first_line_category_card.dart';
import 'package:pickuplines/l18n/app_localizations.dart';

class GirlsFirstLinesScreen extends StatefulWidget {
  const GirlsFirstLinesScreen({super.key});

  @override
  State<GirlsFirstLinesScreen> createState() => _GirlsFirstLinesScreenState();
}

class _GirlsFirstLinesScreenState extends State<GirlsFirstLinesScreen> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: t.firstLineForHer,
        // showBackButton: false,
        height: AppSizes.appBarHeightDetail,
        subtitle: t.conversationStarterThatConnect,
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: AppSizes.appBarHeightDetailPadding,
          left: 20,
          right: 20,
          bottom: 100,
        ),
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
    );
  }
}
