import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/database_connection/database_reviews.dart';
import 'package:japaneese_app/models/CustomNavigationBar.dart';
import 'package:japaneese_app/models/NavigationDrawerModel.dart';
//import 'package:japaneese_app/models/CustomNavigationBar.dart';
import 'package:japaneese_app/models/appbar/HomePageAppBar.dart';
import 'package:japaneese_app/models/stats/LearningProgressStat.dart';
import 'package:japaneese_app/models/stats/SrsStageStat.dart';
import 'package:japaneese_app/models/text%20fields/TextField.dart';

class HomePage extends StatefulWidget {
  final List<Vocab> totalVocabs;
  final List<Kanji> totalKanjis;
  final List<Vocab> unlockedVocabs;
  final List<Kanji> unlockedKanjis;
  const HomePage(
      {super.key,
      required this.totalVocabs,
      required this.totalKanjis,
      required this.unlockedVocabs,
      required this.unlockedKanjis});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final List<Map<String, dynamic>> srsStageList = [
    {
      "srsLevel": "Apprentice",
      "mainColor": Color(0xFFFF9CE9),
      "vocabCounter": () => kanjiVocabSrsStageCount(false, 'a'),
      "kanjiCounter": () => kanjiVocabSrsStageCount(true, 'a')
    },
    {
      "srsLevel": "Guru",
      "mainColor": Color(0xFFFFC2B9),
      "vocabCounter": () => kanjiVocabSrsStageCount(false, 'g'),
      "kanjiCounter": () => kanjiVocabSrsStageCount(true, 'g')
    },
    {
      "srsLevel": "Master",
      "mainColor": Color(0xFF8F87F1),
      "vocabCounter": () => kanjiVocabSrsStageCount(false, 'm'),
      "kanjiCounter": () => kanjiVocabSrsStageCount(true, 'm')
    },
    {
      "srsLevel": "Enlightened",
      "mainColor": Color(0xFF385B94),
      "vocabCounter": () => kanjiVocabSrsStageCount(false, 'e'),
      "kanjiCounter": () => kanjiVocabSrsStageCount(true, 'e')
    },
    {
      "srsLevel": "Burned",
      "mainColor": Color(0xFF1E1E1E),
      "vocabCounter": () => kanjiVocabSrsStageCount(false, 'b'),
      "kanjiCounter": () => kanjiVocabSrsStageCount(true, 'b')
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFE8F9FF),
      appBar: HomePageAppBar(
          username: "username",
          level: "1",
          userImagePath: "assets/images/Oval.png",
          onTapDrawer: () => _scaffoldKey.currentState
              ?.openDrawer() // Open drawer on avatar tap,
          ),
      drawer: NavigationDrawerCustomModel(),
      bottomNavigationBar: CustomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/lessons');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/reviews');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/settings');
            }
          }),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(),
            SizedBox(
              height: 20,
            ),
            Text(
              " Learning progress",
              style: const TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 30,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 20,
            ),
            LearningProgressStat(
              mainColor: Color(0xFFFF8DA1),
              secondColor: Color(0xFFFFFFFF),
              name: "Kanji",
              nameInJapaneese: "漢字",
              totalKanjis: widget.totalKanjis,
              unlockedKanjis: widget.unlockedKanjis,
            ),
            SizedBox(
              height: 20,
            ),
            LearningProgressStat(
              mainColor: Color(0xFFAD56C4),
              secondColor: Color(0xFFFFFFFF),
              name: "Vocabulary",
              nameInJapaneese: "単語",
              totalVocabs: widget.totalVocabs,
              unlockedVocabs: widget.unlockedVocabs,
            ),
            SizedBox(
              height: 20,
            ),
            expansionTileSrsStage(context),
            SizedBox(
              height: 20,
            ),
            listViewSrsStageStat(context)
          ],
        ),
      ),
    );
  }

  Widget expansionTileSrsStage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: lighten(Color.fromARGB(255, 185, 210, 215)),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            iconColor: Color(0xFF1F1F1F),
            collapsedIconColor: Color(0xFF1F1F1F),
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            title: Text(
              "Learning levels",
              style: const TextStyle(
                color: Color(0xFF1F1F1F),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
            children: [
              Text(
                '''there are five main levels of learning kanji and vocabs in this app : 
Apprentice, Guru, Master, Enlightened and Burned ''',
                style: const TextStyle(
                  color: Color(0xFF1F1F1F),
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Poppins",
                ),
              )
            ]),
      ),
    );
  }

  Widget listViewSrsStageStat(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 10),
        scrollDirection: Axis.horizontal,
        itemCount: srsStageList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SrsStageStat(
              mainColor: srsStageList[index]["mainColor"],
              secondColor: const Color(0xFFFFFFFF),
              srsStageLevel: srsStageList[index]["srsLevel"],
              vocabCounter: srsStageList[index]["vocabCounter"],
              kanjiCounter: srsStageList[index]["kanjiCounter"],
            ),
          );
        },
      ),
    );
  }
}
