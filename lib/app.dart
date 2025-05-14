import 'package:flutter/material.dart';
import 'package:pickuplines/features/favourite/saved_screen.dart';
import 'package:pickuplines/features/home/screens/home_screen.dart';
import 'package:pickuplines/features/first_line/screens/first_line_screen.dart';
// import other screens as needed
import 'package:pickuplines/features/navigation/screens/animatedBottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    GirlsFirstLinesScreen(),
    SavedScreen(),
    Center(child: Text("Go to Hell")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
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
