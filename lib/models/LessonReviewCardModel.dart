import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/models/buttons/CustomNormalButton.dart';
import 'package:japaneese_app/pages/kanji_lessons_folder/KanjiLessonCard.dart';
import 'package:japaneese_app/pages/kanji_lessons_folder/kanjiReviewCard.dart';
import 'package:japaneese_app/pages/vocab_lessons_folder/vocabLessonCard.dart';
import 'package:japaneese_app/pages/vocab_lessons_folder/vocabReviewCard.dart';

class LessonReviewCardModel extends StatelessWidget {
  final List<Kanji>? kanjis;
  final List<Vocab>? vocabs;
  final String name;
  final bool isLesson;
  final bool isKanji;
  final int nbre;
  final String imagePath;

  const LessonReviewCardModel({
    super.key,
    required this.name,
    required this.isLesson,
    required this.isKanji,
    required this.nbre,
    required this.imagePath,
    this.kanjis,
    this.vocabs,
  });

  @override
  Widget build(BuildContext context) {
    var nameButton = isLesson ? 'start lessons' : 'start reviews';
    var secondColor = nbre == 0
        ? Color(0xFF1F1F1F)
        : isKanji
            ? Color(0xFFFF8DA1)
            : Color(0xFFAD56C4);
    var mainColor = Color(0xFFFFFFFF);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: nbre == 0
            ? const Color(0xFF1F1F1F)
            : isKanji
                ? const Color(0xFFFF8DA1)
                : const Color(0xFFAD56C4),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.25),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image + type
          Container(
            height: 190,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  imagePath,
                  width: 90,
                  height: 60,
                ),
                Text(
                  isKanji ? "漢字" : "単語",
                  style: TextStyle(
                    color: nbre == 0
                        ? const Color(0xFF1F1F1F)
                        : isKanji
                            ? const Color(0xFFFF8DA1)
                            : const Color(0xFFAD56C4),
                    fontFamily: "Poppins",
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // text and info
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // titles
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today's",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Poppins",
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 100, // adjust as needed
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    // number badge
                    Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$nbre",
                        style: TextStyle(
                          color: nbre == 0
                              ? const Color(0xFF1F1F1F)
                              : isKanji
                                  ? const Color(0xFFFF8DA1)
                                  : const Color(0xFFAD56C4),
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),

                // description text
                Text(
                  nbre == 0
                      ? isLesson
                          ? "No available lessons at the moment, check later!"
                          : "No available reviews at the moment, check later!"
                      : isLesson
                          ? "We cooked up these lessons just for you."
                          : "Review these items to level them up!",
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Poppins",
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                // button

                nbre != 0
                    ? GestureDetector(
                        onTap: () async {
                          if (isKanji && isLesson) {
                            print(" button clicked! : kanjis lessons !! ");
                            if (kanjis!.isNotEmpty) {
                              print("Welco~me");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KanjiLessonCard(
                                          kanjiList: kanjis!,
                                          currentKanjiIndex: 0,
                                          isLesson: true,
                                        )),
                              );
                            } else {
                              print("i am empty mate !! ");
                            }
                          } else if (!isKanji && isLesson) {
                            print(" button clicked! : vocabs lessons !! ");
                            if (vocabs!.isNotEmpty) {
                              print("Welco~me");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VocabLessonCard(
                                          vocabList: vocabs!,
                                          currentKanjiIndex: 0,
                                          isLesson: true,
                                        )),
                              );
                            } else {
                              print("i am empty mate !! ");
                            }
                          } else if (!isLesson && isKanji) {
                            print("hello kaiba !!");
                            if (kanjis!.isNotEmpty) {
                              print("Welco~me");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KanjiReviewCard(
                                          kanjiList: kanjis!,
                                          currentKanjiIndex: 0,
                                          isLesson: false,
                                        )),
                              );
                            } else {
                              print("i am empty mate !! ");
                            }
                          } else if (!isLesson && !isKanji) {
                            print("welcome to my soul society !!");
                            if (vocabs!.isNotEmpty) {
                              print("Welco~me");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VocabReviewCard(
                                          vocabList: vocabs!,
                                          currentKanjiIndex: 0,
                                          isLesson: false,
                                        )),
                              );
                            } else {
                              print("i am empty mate !! ");
                            }
                          }
                        },
                        child: CustomNormalButton(
                            name: nameButton,
                            mainColor: mainColor,
                            secondColor: secondColor))
                    : SizedBox(
                        height: 0,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
