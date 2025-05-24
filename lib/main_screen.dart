import 'package:flutter/material.dart';
import 'package:pickuplines/features/auth/services/auth_service.dart';
import 'package:pickuplines/features/favourite/saved_screen.dart';
import 'package:pickuplines/features/home/screens/home_screen.dart';
import 'package:pickuplines/features/first_line/screens/first_line_screen.dart';
import 'package:pickuplines/features/navigation/screens/animatedBottom_bar.dart';
import 'package:provider/provider.dart';

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
  ];

  void _handleSignOut(BuildContext context) async {
    final authService = context.read<AuthService>();
    await authService.signOut();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleSignOut(context),
          ),
        ],
      ),
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
