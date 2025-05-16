import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickuplines/core/utils/services/favorite_ser.dart';
import 'package:pickuplines/features/home/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/widgets/alertbox.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/screens/first_line_screen.dart';
import 'package:pickuplines/features/home/controller/flirt_services.dart';
import 'package:pickuplines/features/home/widgets/top_flirt_line.dart';
import 'package:pickuplines/features/home/widgets/flirt_details_screen.dart';
import 'package:pickuplines/features/home/widgets/pointed_quotes_card.dart';
import 'package:pickuplines/l18n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FlirtServices>().loadFlirtContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final flirtServices = Provider.of<FlirtServices>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: t.firstLine,
        showBackButton: false,
        showMenuButton: true,
        height: AppSizes.appBarHeightDetail,
        subtitle: t.weHavePickedSomeLineFor,
     
      ),
      drawer: const AppDrawer(),
      body:
          flirtServices.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.only(
                  top: 150.h,
                  left: 20.h,
                  right: 20.h,
                  bottom: 100.h,
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
                            color: const Color(0xFFFF6B9E),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          t.topFlirtLines,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const GirlsFirstLinesScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See All',
                            style: const TextStyle(
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
                        for (
                          var i = 0;
                          i < flirtServices.topCategoryLines.length;
                          i++
                        )
                          Padding(
                            padding: EdgeInsets.only(
                              right:
                                  i < flirtServices.topCategoryLines.length - 1
                                      ? 16
                                      : 0,
                            ),
                            child: TopFlirtLines(
                              category:
                                  flirtServices.topCategoryLines[i]['category'],
                              line: flirtServices.topCategoryLines[i]['line'],
                              color: flirtServices.getColorForCategory(
                                flirtServices.topCategoryLines[i]['category'],
                              ),
                              onCopy:
                                  () => _copyToClipboard(
                                    flirtServices.topCategoryLines[i]['line'],
                                  ),
                              onFavorite:
                                  () => _saveToFavorites(
                                    flirtServices.topCategoryLines[i],
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
                            color: const Color(0xFF5EAFC0),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                    itemCount: flirtServices.flirtLines.length,
                    itemBuilder: (context, index) {
                      final flirt = flirtServices.flirtLines[index];
                      return Column(
                        children: [
                          PointedFlirtCard(
                            title: flirt['line'],
                            author: flirt['category'],
                            color: flirtServices.getColorForCategory(
                              flirt['category'],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => FlirtDetailScreen(
                                        flirt: flirt['line'],
                                        author: flirt['category'],
                                        tags: List<String>.from(flirt['tags']),
                                        color: flirtServices
                                            .getColorForCategory(
                                              flirt['category'],
                                            ),
                                      ),
                                ),
                              );
                            },
                          ),
                          if (index < flirtServices.flirtLines.length - 1)
                            const SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ],
              ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final randomFlirtLine = flirtServices.getRandomFlirtLine();
          if (randomFlirtLine == null) return;

          showDialog(
            context: context,
            builder: (context) {
              return AlertBox(randomFlirtLine: randomFlirtLine);
            },
          );
        },
        backgroundColor: const Color(0xFFFF6B9E),
        child: const Icon(Icons.favorite, color: Colors.white),
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }

  void _saveToFavorites(Map<String, dynamic> flirt) async {
    try {
      await FavoritesService.saveLine(flirt);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Added to favorites')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save to favorites')),
      );
    }
  }
}
