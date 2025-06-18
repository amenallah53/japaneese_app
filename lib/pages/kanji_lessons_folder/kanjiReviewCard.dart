import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/models/buttons/CustomNormalButton.dart';
import 'package:japaneese_app/models/cards/KanjiVocabCard.dart';
import 'package:japaneese_app/pages/kanji_lessons_folder/kanjiReviewCardResult.dart';

class KanjiReviewCard extends StatelessWidget {
  final List<Kanji> kanjiList;
  final int currentKanjiIndex;
  final bool isLesson;
  const KanjiReviewCard(
      {super.key,
      required this.kanjiList,
      required this.currentKanjiIndex,
      required this.isLesson});

  @override
  Widget build(BuildContext context) {
    Kanji kanji = kanjiList[currentKanjiIndex];
    return Scaffold(
        backgroundColor: Color(0xFFE8F9FF),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Pink header with kanji
              KanjiVocabCard(
                mainColor: Color(0xFFFF8DA1),
                kanji: kanji,
                word: null,
                cardsLeftCount: kanjiList.length,
                isLesson: isLesson,
              ),

              // button
              GestureDetector(
                  onTap: () async {
                    print(" button clicked!");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KanjiReviewCardResult(
                                kanjiList: kanjiList,
                                currentKanjiIndex: currentKanjiIndex,
                                isLesson: isLesson,
                              )),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: CustomNormalButton(
                        name: "see results",
                        mainColor: Color(0xFFFF8DA1),
                        secondColor: Color(0xFFFFFFFF)),
                  )),
            ]));
  }
}
