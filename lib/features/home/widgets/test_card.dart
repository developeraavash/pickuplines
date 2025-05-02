import 'package:pickuplines/core/constants/sizes.dart';
import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;

  const TestCard({
    required this.title,
    required this.description,
    required this.icon,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(TSize.defaultSpace),
        leading: Image.asset(icon, width: 40, height: 40),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: TSize.md,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
