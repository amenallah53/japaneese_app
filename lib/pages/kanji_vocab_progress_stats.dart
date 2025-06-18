import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/models/CustomNavigationBar.dart';
import 'package:japaneese_app/models/appbar/OtherPageAppBar.dart';
import 'package:japaneese_app/models/stats/LearningProgressStat.dart';
import 'package:japaneese_app/pages/kanji_vocab_info/kanji_info.dart';
import 'package:japaneese_app/pages/kanji_vocab_info/vocab_info.dart';

class KanjiVocabProgressStats extends StatefulWidget {
  final bool isKanji;
  final List<Kanji>? listKanji;
  final List<Vocab>? listVocab;
  final int nbreTotal;
  const KanjiVocabProgressStats(
      {super.key,
      required this.isKanji,
      this.listKanji,
      this.listVocab,
      required this.nbreTotal});

  @override
  State<KanjiVocabProgressStats> createState() =>
      _KanjiVocabProgressStatsState();
}

class _KanjiVocabProgressStatsState extends State<KanjiVocabProgressStats> {
  @override
  Widget build(BuildContext context) {
    var list = widget.isKanji ? widget.listKanji : widget.listVocab;
    var name = widget.isKanji ? " Kanji Progress" : " Vocabulary Progress";
    var sndName = widget.isKanji ? "Kanji Learned" : "Vocabulary Learned";
    var color = widget.isKanji ? Color(0xFFFF8DA1) : Color(0xFFAD56C4);
    final double progressValue =
        widget.nbreTotal == 0 ? 0 : (list?.length ?? 0) / widget.nbreTotal;

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
              name,
              style: const TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 30,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 20),
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
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sndName,
                        style: const TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${list?.length ?? 0} / ${widget.nbreTotal}",
                        style: const TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 30,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Grid container for kanji/vocab items
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Learned items",
                      style: const TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.isKanji ? 5 : 1,
                        crossAxisSpacing: widget.isKanji ? 10 : 0,
                        mainAxisSpacing: 10,
                        childAspectRatio: widget.isKanji ? 1.0 : 3.5,
                      ),
                      itemCount: list?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (widget.isKanji) {
                              print((list[index] as Kanji).kanji);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => KanjiInfo(
                                          kanji: (list[index] as Kanji),
                                          color: color)));
                            } else {
                              print((list[index] as Vocab).word);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VocabInfo(
                                          vocab: (list[index] as Vocab),
                                          color: color)));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
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
                            /*child: Center(*/
                            child: widget.isKanji
                                ? Center(
                                    child: Text(
                                    (list![index] as Kanji).kanji,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ))
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        (list![index] as Vocab).word,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        (list[index] as Vocab).meaning,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                            /*),*/
                          ),
                        );
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
