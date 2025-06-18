import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';

class KanjiVocabCard extends StatelessWidget {
  final Kanji? kanji;
  final Vocab? word;
  final bool? isLesson;
  final int cardsLeftCount;
  final Color mainColor;

  const KanjiVocabCard({
    super.key,
    required this.kanji,
    required this.word,
    required this.cardsLeftCount,
    required this.mainColor,
    required this.isLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          color: mainColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.25),
              blurRadius: 5,
              spreadRadius: 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      //Navigator.popUntil(context, (route) => route.isFirst);
                      //DefaultTabController.of(context).animateTo(0);
                      var routeDirection = isLesson == null
                          ? '/home'
                          : isLesson!
                              ? '/lessons'
                              : '/reviews';
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        routeDirection,
                        (route) => false,
                      );
                    },
                    icon: Icon(
                      Icons.home,
                      color: Color(0xFFFFFFFF),
                    )),
                Text(
                  "Cards left : ${cardsLeftCount}",
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontFamily: "Poppins",
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(
                  kanji != null ? kanji!.kanji : word!.word,
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontFamily: "Poppins",
                    fontSize: 75,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
