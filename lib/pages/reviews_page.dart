import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/models/CustomNavigationBar.dart';
import 'package:japaneese_app/models/LessonReviewCardModel.dart';
import 'package:japaneese_app/models/appbar/OtherPageAppBar.dart';

class ReviewsPage extends StatelessWidget {
  final List<Kanji>? kanjiList;
  final List<Vocab>? vocabList;
  const ReviewsPage({super.key, this.kanjiList, this.vocabList});

  @override
  Widget build(BuildContext context) {
    kanjiList!.shuffle();
    vocabList!.shuffle();
    return Scaffold(
        backgroundColor: Color(0xFFE8F9FF),
        appBar: OtherPageAppBar(userImagePath: "assets/images/Oval.png"),
        bottomNavigationBar: CustomNavigationBar(
            currentIndex: 2,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, '/home');
              } else if (index == 1) {
                Navigator.pushNamed(context, '/lessons');
              } else if (index == 3) {
                Navigator.pushNamed(context, '/settings');
              }
            }),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                " Today's reviews",
                style: const TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 30,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 20,
              ),
              LessonReviewCardModel(
                  kanjis: kanjiList,
                  name: "Kanji reviews",
                  isLesson: false,
                  isKanji: true,
                  nbre: kanjiList!.length,
                  imagePath: 'assets/images/wanikani_race.png'),
              SizedBox(
                height: 20,
              ),
              LessonReviewCardModel(
                  vocabs: vocabList,
                  name: "Vocab reviews",
                  isLesson: false,
                  isKanji: false,
                  nbre: vocabList!.length,
                  imagePath: 'assets/images/wanikani_bird.png'),
            ])));
  }
}
