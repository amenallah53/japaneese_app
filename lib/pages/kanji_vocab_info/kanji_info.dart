import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/models/cards/KanjiVocabCard.dart';
import 'package:japaneese_app/models/stats/LearningProgressStat.dart';

class KanjiInfo extends StatefulWidget {
  final Kanji kanji;
  final Color color;
  const KanjiInfo({super.key, required this.kanji, required this.color});

  @override
  State<KanjiInfo> createState() => _KanjiInfoState();
}

class _KanjiInfoState extends State<KanjiInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8F9FF),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            KanjiVocabCard(
                kanji: widget.kanji,
                word: null,
                cardsLeftCount: 0,
                mainColor: widget.color,
                isLesson: null),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                children: [
                  Text(
                    widget.kanji.meaning,
                    style: TextStyle(
                      color: const Color(0xFF1F1F1F),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  onkunreadings(context, true, widget.kanji.onReading),
                  SizedBox(
                    height: 20,
                  ),
                  onkunreadings(context, false, widget.kanji.kunReading),
                  SizedBox(
                    height: 20,
                  ),
                  currentStreakAndLevel(context, widget.kanji, widget.color)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget onkunreadings(BuildContext context, bool isOnyomi, String reading) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: lighten(Color.fromARGB(255, 185, 210, 215)),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.25),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            isOnyomi ? "On'yomi reading(s) : " : "Kun'yomi reading(s) : ",
            style: TextStyle(
              color: const Color(0xFF1F1F1F),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            reading,
            maxLines: 2,
            style: TextStyle(
              color: const Color(0xFF1F1F1F),
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget currentStreakAndLevel(BuildContext context, Kanji kanji, Color color) {
    var progressValue = kanji.correctCounter! / 20;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: lighten(Color.fromARGB(255, 185, 210, 215)),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.25),
            blurRadius: 5,
            spreadRadius: 0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Correct streak : ",
            style: TextStyle(
              color: const Color(0xFF1F1F1F),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 30,
                    backgroundColor: Colors.white.withOpacity(0.5),
                    color: color,
                  ),
                ),
                Center(
                  child: Text(
                    "${kanji.correctCounter} / 20",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Learning level : ",
                style: TextStyle(
                  color: const Color(0xFF1F1F1F),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                levelSrs(kanji.srsStageId == "" ? "" : kanji.srsStageId![0]),
                style: TextStyle(
                  color: colorSrs(
                      kanji.srsStageId == "" ? "" : kanji.srsStageId![0]),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Next review time : ",
                style: TextStyle(
                  color: const Color(0xFF1F1F1F),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                kanji.nextReviewTime == null
                    ? "N/A"
                    : kanji.nextReviewTime!.toIso8601String().substring(0, 10),
                style: TextStyle(
                  color: const Color(0xFF1F1F1F),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String levelSrs(String id) {
    late String lvlSrs;
    switch (id) {
      case "":
        lvlSrs = "N/A";
        break;
      case "a":
        lvlSrs = "Apprentice";
        break;
      case "g":
        lvlSrs = "Guru";
        break;
      case "m":
        lvlSrs = "Master";
        break;
      case "e":
        lvlSrs = "Enlightened";
        break;
      case "b":
        lvlSrs = "Burned";
        break;
    }
    return lvlSrs;
  }

  Color colorSrs(String id) {
    late Color color;
    switch (id) {
      case "":
        color = Color(0xFF1F1F1F);
        break;
      case "a":
        color = Color(0xFFFF9CE9);
        break;
      case "g":
        color = Color(0xFFFFC2B9);
        break;
      case "m":
        color = Color(0xFF8F87F1);
        break;
      case "e":
        color = Color(0xFF385B94);
        break;
      case "b":
        color = Color(0xFF1E1E1E);
        break;
    }
    return color;
  }
}
