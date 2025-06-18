import 'package:flutter/material.dart';
import 'package:japaneese_app/models/buttons/nav%20buttons/CustomNavigationKanaButton.dart';
import 'package:japaneese_app/models/buttons/nav%20buttons/CustomNavigationKanjiButton.dart';
import 'package:japaneese_app/models/buttons/nav%20buttons/CustomNavigationVocabButton.dart';

class OtherPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userImagePath;

  const OtherPageAppBar({
    super.key,
    required this.userImagePath,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(100); // Match container height

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(userImagePath),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomNavigationKanaButton(
                  name: "kana",
                  mainColor: Color(0xFFEAB92F),
                  secondColor: Color(0xFFE8F9FF),
                ),
                SizedBox(
                  width: 10,
                ),
                CustomNavigationKanjiButton(
                    name: "kanji",
                    mainColor: Color(0xFFFF8DA1),
                    secondColor: Color(0xFFE8F9FF)),
                SizedBox(
                  width: 10,
                ),
                CustomNavigationVocabButton(
                    name: "vocab",
                    mainColor: Color(0xFFAD56C4),
                    secondColor: Color(0xFFE8F9FF)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
