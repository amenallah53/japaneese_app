import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/database_connection/database_lessons.dart';
import 'package:japaneese_app/models/buttons/CustomNormalButton.dart';
import 'package:japaneese_app/models/cards/KanjiVocabCard.dart';
import 'package:japaneese_app/pages/kanji_lessons_folder/kanjiReviewCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KanjiReviewCardResult extends StatelessWidget {
  final List<Kanji> kanjiList;
  final int currentKanjiIndex;
  final bool isLesson;
  const KanjiReviewCardResult(
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
        children: [
          // Pink header with kanji
          KanjiVocabCard(
            mainColor: Color(0xFFFF8DA1),
            kanji: kanji,
            word: null,
            cardsLeftCount: kanjiList.length,
            isLesson: isLesson,
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  kanji.meaning,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F1F1F),
                    fontFamily: "Poppins",
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                )),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "On'yomi reading",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F1F1F),
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  kanji.onReading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F1F1F),
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Kun'yomi reading",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F1F1F),
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  kanji.kunReading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F1F1F),
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // button(s)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          print(" button clicked!");
                          var failedToRememberKanji = kanjiList[0];
                          learningLevelDowngrade(failedToRememberKanji);
                          kanjiList.removeAt(0);
                          kanjiList.add(failedToRememberKanji);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KanjiReviewCard(
                                      kanjiList: kanjiList,
                                      currentKanjiIndex: 0,
                                      isLesson: isLesson,
                                    )),
                          );
                        },
                        child: CustomNormalButton(
                            name: "again",
                            mainColor: Color(0xFFB10020),
                            secondColor: Color(0xFFFFFFFF))),
                    GestureDetector(
                        onTap: () async {
                          print(" button clicked!");
                          learningLevelUpgrade(kanji);
                          updateState(kanji, true);
                          deleteFromLessonQueue(kanji, true);
                          kanjiList.removeAt(0);
                          if (kanjiList.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KanjiReviewCard(
                                        kanjiList: kanjiList,
                                        currentKanjiIndex: 0,
                                        isLesson: isLesson,
                                      )),
                            );
                          } else {
                            /*Navigator.popUntil(
                                context, (route) => route.isFirst);
                            DefaultTabController.of(context).animateTo(0);*/
                            if (isLesson) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('last_kanji_lesson_login',
                                  DateTime.now().toIso8601String());
                            }
                            var routeDirection =
                                isLesson ? '/lessons' : '/reviews';
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              routeDirection,
                              (route) => false,
                            );
                          }
                        },
                        child: CustomNormalButton(
                            name: "good",
                            mainColor: Color(0xFF009903),
                            secondColor: Color(0xFFFFFFFF))),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
