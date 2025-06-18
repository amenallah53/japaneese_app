import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/models/buttons/CustomNormalButton.dart';
import 'package:japaneese_app/models/cards/KanjiVocabCard.dart';
import 'package:japaneese_app/pages/vocab_lessons_folder/vocabReviewCard.dart';

class VocabLessonCard extends StatelessWidget {
  final List<Vocab> vocabList;
  final int currentKanjiIndex;
  final bool isLesson;
  const VocabLessonCard(
      {super.key,
      required this.vocabList,
      required this.currentKanjiIndex,
      required this.isLesson});

  @override
  Widget build(BuildContext context) {
    Vocab vocab = vocabList[currentKanjiIndex];
    return Scaffold(
      backgroundColor: Color(0xFFE8F9FF),
      body: Column(
        children: [
          // Pink header with kanji
          KanjiVocabCard(
            mainColor: Color(0xFFAD56C4),
            kanji: null,
            word: vocab,
            cardsLeftCount: vocabList.length - currentKanjiIndex,
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
                  vocab.meaning,
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
                  "reading(s)",
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
                  vocab.reading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1F1F1F),
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 25,
                ),
                // button
                GestureDetector(
                    onTap: () async {
                      print(" button clicked!");
                      if (currentKanjiIndex != vocabList.length - 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VocabLessonCard(
                                    currentKanjiIndex: currentKanjiIndex + 1,
                                    vocabList: vocabList,
                                    isLesson: isLesson,
                                  )),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VocabReviewCard(
                                    vocabList: vocabList,
                                    currentKanjiIndex: 0,
                                    isLesson: isLesson,
                                  )),
                        );
                        //Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    },
                    child: currentKanjiIndex != vocabList.length - 1
                        ? CustomNormalButton(
                            name: "next card",
                            mainColor: Color(0xFFAD56C4),
                            secondColor: Color(0xFFFFFFFF))
                        : CustomNormalButton(
                            name: "to review",
                            mainColor: Color(0xFFAD56C4),
                            secondColor: Color(0xFFFFFFFF))),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
