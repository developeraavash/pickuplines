import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pickuplines/core/constants/app_sizes.dart';
import 'package:pickuplines/core/widgets/curved/curved_appbar.dart';
import 'package:pickuplines/features/first_line/widgets/category_chip.dart';
import 'package:pickuplines/features/first_line/widgets/first_line_category_card.dart';
import 'package:pickuplines/features/first_line/controller/first_line_controller.dart';
import 'package:pickuplines/l18n/app_localizations.dart';
import 'package:pickuplines/aLoadFunc/upload_data.dart';

class GirlsFirstLinesScreen extends StatefulWidget {
  const GirlsFirstLinesScreen({super.key});

  @override
  State<GirlsFirstLinesScreen> createState() => _GirlsFirstLinesScreenState();
}

class _GirlsFirstLinesScreenState extends State<GirlsFirstLinesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FirstLineController>().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final controller = Provider.of<FirstLineController>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CurvedAppBar(
        title: t.firstLineForHer,
        height: AppSizes.appBarHeightDetail,
        subtitle: t.conversationStarterThatConnect,
      ),
      body:
          controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.categories.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(t.noCategoriesFound),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        controller.setLoading(true);
                        await uploadCategoryData();
                        await controller.loadCategories();
                      },
                      child: const Text('Upload Categories'),
                    ),
                  ],
                ),
              )
              : ListView(
                padding: EdgeInsets.only(
                  top: AppSizes.appBarHeightDetailPadding,
                  left: 20,
                  right: 20,
                  bottom: 100,
                ),
                children: [
                  // Category chips
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          controller.categories.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: 8.h),
                            child: CategoryChip(
                              label: controller.categories[index]['title'],
                              color: controller.getColorFromHex(
                                controller.categories[index]['color'],
                              ),
                              isSelected: controller.selectedIndex == index,
                              onSelected: () {
                                controller.setSelectedIndex(index);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Selected category card
                  if (controller.categories.isNotEmpty)
                    FirstLineCategoryCard(
                      title:
                          controller.categories[controller
                              .selectedIndex]['title'],
                      subtitle:
                          controller.categories[controller
                              .selectedIndex]['subtitle'],
                      icon: controller.getIconFromString(
                        controller.categories[controller.selectedIndex]['icon'],
                      ),
                      color: controller.getColorFromHex(
                        controller.categories[controller
                            .selectedIndex]['color'],
                      ),
                      lines: List<String>.from(
                        controller.categories[controller
                            .selectedIndex]['lines'],
                      ),
                    ),
                ],
              ),
    );
  }
}
