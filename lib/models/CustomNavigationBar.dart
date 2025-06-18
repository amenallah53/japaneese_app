// lib/widgets/custom_bottom_navbar.dart
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: const Color(0xFFFFFFFF),
      indicatorColor: const Color(0xFF273767),
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Colors.white),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.menu_book_rounded, color: Colors.white),
          icon: Icon(Icons.menu_book_rounded),
          label: 'Lessons',
        ),
        NavigationDestination(
          selectedIcon:
              Icon(Icons.assignment_turned_in_rounded, color: Colors.white),
          icon: Icon(Icons.assignment_turned_in_rounded),
          label: 'Reviews',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings, color: Colors.white),
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
