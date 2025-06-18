import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/models/CustomNavigationBar.dart';
import 'package:japaneese_app/models/LessonReviewCardModel.dart';
import 'package:japaneese_app/models/appbar/OtherPageAppBar.dart';

class LessonsPage extends StatelessWidget {
  final List<Kanji>? kanjiList;
  final List<Vocab>? vocabList;
  //final VoidCallback onSetState;
  const LessonsPage({
    super.key,
    this.kanjiList,
    this.vocabList,
    /*required this.onSetState*/
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F9FF),
      appBar: OtherPageAppBar(userImagePath: "assets/images/Oval.png"),
      bottomNavigationBar: CustomNavigationBar(
          currentIndex: 1,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/reviews');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/settings');
            }
          }),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's lessons",
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 30,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            LessonReviewCardModel(
              kanjis: kanjiList,
              name: "Kanji lessons",
              isLesson: true,
              isKanji: true,
              nbre: kanjiList!.length,
              imagePath: 'assets/images/wanikani_turtle.png',
            ),
            const SizedBox(height: 20),
            LessonReviewCardModel(
              vocabs: vocabList,
              name: "Vocab lessons",
              isLesson: true,
              isKanji: false,
              nbre: vocabList!.length,
              imagePath: 'assets/images/wanikani_study.png',
            ),
          ],
        ),
      ),
    );
  }
}
