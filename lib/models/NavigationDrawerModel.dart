import 'package:flutter/material.dart';

class NavigationDrawerCustomModel extends StatelessWidget {
  const NavigationDrawerCustomModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            const SizedBox(height: 20),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/images/Oval.png"),
          ),
          const SizedBox(height: 10),
          Column(
            children: const [
              Text(
                "username",
                style: TextStyle(
                  color: Color(0xFF1F1F1F),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                "レベル 1",
                style: TextStyle(
                  color: Color(0xFF1F1F1F),
                  fontSize: 15,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Column(
      children: [
        buildMenuItem(context, "あ/ア kana", const Color(0xFFEAB92F)),
        buildMenuItem(context, "漢字 kanji", const Color(0xFFFF8DA1)),
        buildMenuItem(context, "単語 vocabulary", const Color(0xFFAD56C4)),
      ],
    );
  }

  Widget buildMenuItem(BuildContext context, String name, Color color) {
    List<String> _list = ["hiragana", "katakana"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            title: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
            children: List.generate(
              color != Color(0xFFEAB92F) ? 10 : _list.length,
              (index) => ListTile(
                contentPadding: EdgeInsets.zero, // removes internal padding
                title: Center(
                  heightFactor: 1,
                  child: Text(
                    color != Color(0xFFEAB92F)
                        ? "level ${index + 1}"
                        : _list[index],
                    style: const TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                onTap: () {
                  print("$index");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
