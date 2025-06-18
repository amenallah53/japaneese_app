import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String level;
  final String userImagePath;
  final VoidCallback onTapDrawer;

  const HomePageAppBar({
    super.key,
    required this.username,
    required this.level,
    required this.userImagePath,
    required this.onTapDrawer,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(225); // Match container height

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.25),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF385B94), Color(0xFF273767)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTapDrawer,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(userImagePath),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, $username",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "レベル $level",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
