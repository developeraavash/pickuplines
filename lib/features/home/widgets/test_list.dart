import 'package:pickuplines/features/home/widgets/test_items.dart';
import 'package:flutter/material.dart';

class TestList extends StatelessWidget {
  const TestList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TestItem(
          icon: Icons.brightness_1,
          title: 'Ishihara Test',
          description: 'Identify numbers in colored dots.',
        ),
        TestItem(
          icon: Icons.palette,
          title: 'Red-Green Test',
          description: 'Solve difficulty in seeing red and green colors.',
        ),
        TestItem(
          icon: Icons.looks_3,
          title: 'Tritanopia Test',
          description: 'Test for blue-yellow color blindness.',
        ),
        TestItem(
          icon: Icons.traffic,
          title: 'Lantern Test',
          description: 'Assess color perception at a distance.',
        ),
        TestItem(
          icon: Icons.numbers,
          title: 'Number Recognition Test',
          description: 'Identify numbers in various colors.',
        ),
      ],
    );
  }
}
