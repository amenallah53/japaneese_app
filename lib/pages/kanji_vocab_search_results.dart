import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/models/CustomNavigationBar.dart';
import 'package:japaneese_app/models/appbar/OtherPageAppBar.dart';
import 'package:japaneese_app/models/stats/LearningProgressStat.dart';
import 'package:japaneese_app/pages/kanji_vocab_info/kanji_info.dart';
import 'package:japaneese_app/pages/kanji_vocab_info/vocab_info.dart';

class KanjiVocabSearchResults extends StatelessWidget {
  final String searchedString;
  final List<Kanji> listKanji;
  final List<Vocab> listVocab;
  const KanjiVocabSearchResults(
      {super.key,
      required this.listKanji,
      required this.listVocab,
      required this.searchedString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE8F9FF),
        appBar: OtherPageAppBar(userImagePath: "assets/images/Oval.png"),
        bottomNavigationBar: CustomNavigationBar(
            currentIndex: 0,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushNamed(context, '/home');
              } else if (index == 1) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search",
                    style: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 30,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${listKanji.length + listVocab.length} results found for ",
                        style: const TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        searchedString,
                        style: const TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  //Grid Layer
                  Container(
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
                    padding: EdgeInsets.all(20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3.5,
                      ),
                      itemCount: listKanji.length + listVocab.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (index >= listKanji.length) {
                              print((listVocab[index - listKanji.length]));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VocabInfo(
                                          vocab: listVocab[
                                              index - listKanji.length],
                                          color: Color(0xFFAD56C4))));
                            } else {
                              print(listKanji[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KanjiInfo(
                                          kanji: listKanji[index],
                                          color: Color(0xFFFF8DA1))));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: index >= listKanji.length
                                  ? Color(0xFFAD56C4)
                                  : Color(0xFFFF8DA1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  index >= listKanji.length
                                      ? listVocab[index - listKanji.length].word
                                      : listKanji[index].kanji,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  index >= listKanji.length
                                      ? listVocab[index - listKanji.length]
                                          .meaning
                                      : listKanji[index].meaning,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ])));
  }
}
