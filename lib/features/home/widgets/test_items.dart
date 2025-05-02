import 'package:flutter/material.dart';

class TestItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const TestItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      onTap: () {
        // Todo - Implement navigation to test details
        // Navigate to specific test details or actions
      },
    );
  }
}
