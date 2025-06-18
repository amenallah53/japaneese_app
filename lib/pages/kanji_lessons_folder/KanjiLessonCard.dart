import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/models/buttons/CustomNormalButton.dart';
import 'package:japaneese_app/models/cards/KanjiVocabCard.dart';
import 'package:japaneese_app/pages/kanji_lessons_folder/kanjiReviewCard.dart';

class KanjiLessonCard extends StatefulWidget {
  final List<Kanji> kanjiList;
  final int currentKanjiIndex;
  final bool isLesson;
  const KanjiLessonCard(
      {super.key,
      required this.kanjiList,
      required this.currentKanjiIndex,
      required this.isLesson});

  @override
  State<KanjiLessonCard> createState() => _KanjiLessonCardState();
}

class _KanjiLessonCardState extends State<KanjiLessonCard> {
  @override
  Widget build(BuildContext context) {
    Kanji kanji = widget.kanjiList[widget.currentKanjiIndex];
    return Scaffold(
      backgroundColor: Color(0xFFE8F9FF),
      body: Column(
        children: [
          // Pink header with kanji
          KanjiVocabCard(
            mainColor: Color(0xFFFF8DA1),
            kanji: kanji,
            word: null,
            cardsLeftCount: widget.kanjiList.length - widget.currentKanjiIndex,
            isLesson: widget.isLesson,
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
                // button
                GestureDetector(
                    onTap: () async {
                      print(" button clicked!");
                      if (widget.currentKanjiIndex !=
                          widget.kanjiList.length - 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KanjiLessonCard(
                                    kanjiList: widget.kanjiList,
                                    currentKanjiIndex:
                                        widget.currentKanjiIndex + 1,
                                    isLesson: true,
                                  )),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KanjiReviewCard(
                                  isLesson: true,
                                  kanjiList: widget.kanjiList,
                                  currentKanjiIndex: 0)),
                        );
                        //Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    },
                    child:
                        widget.currentKanjiIndex != widget.kanjiList.length - 1
                            ? CustomNormalButton(
                                name: "next card",
                                mainColor: Color(0xFFFF8DA1),
                                secondColor: Color(0xFFFFFFFF))
                            : CustomNormalButton(
                                name: "to review",
                                mainColor: Color(0xFFFF8DA1),
                                secondColor: Color(0xFFFFFFFF))),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
