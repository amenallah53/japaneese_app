import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/database_connection/database_lessons.dart';
import 'package:japaneese_app/models/buttons/CustomNormalButton.dart';
import 'package:japaneese_app/models/text%20fields/VocabReviewsCustomTextField.dart';
import 'package:japaneese_app/models/cards/KanjiVocabCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VocabReviewCard extends StatefulWidget {
  final List<Vocab> vocabList;
  final int currentKanjiIndex;
  final bool isLesson;
  const VocabReviewCard(
      {super.key,
      required this.vocabList,
      required this.currentKanjiIndex,
      required this.isLesson});
  @override
  State<VocabReviewCard> createState() => _VocabReviewCardState();
}

class _VocabReviewCardState extends State<VocabReviewCard> {
  Color cardColor = const Color(0xFFAD56C4);
  bool isFirstTap = true;
  bool isShowResult = false;
  late TextEditingController _meaningController;
  late TextEditingController _readingController;
  late TextEditingController _meaningControllerTemp;
  late TextEditingController _readingControllerTemp;

  @override
  void initState() {
    super.initState();
    _meaningController = TextEditingController();
    _readingController = TextEditingController();
    _meaningControllerTemp = TextEditingController();
    _readingControllerTemp = TextEditingController();
  }

  @override
  void dispose() {
    _meaningController.dispose();
    _readingController.dispose();
    _meaningControllerTemp.dispose();
    _readingControllerTemp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Vocab vocab = widget.vocabList[widget.currentKanjiIndex];
    return Scaffold(
        backgroundColor: const Color(0xFFE8F9FF),
        body: Column(children: [
          KanjiVocabCard(
            mainColor: cardColor,
            kanji: null,
            word: vocab,
            cardsLeftCount: widget.vocabList.length,
            isLesson: widget.isLesson,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //const SizedBox(height: 20),
                  const Text(
                    "Meaning : ",
                    style: TextStyle(
                      color: Color(0xFF1F1F1F),
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  VocabReviewsCustomTextField(
                    key: ValueKey("meaning_${isShowResult.toString()}"),
                    borderColor: cardColor,
                    vocab: vocab,
                    isMeaning: true,
                    controller: !isShowResult
                        ? _meaningController
                        : _meaningControllerTemp,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Reading : ",
                    style: TextStyle(
                      color: Color(0xFF1F1F1F),
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  VocabReviewsCustomTextField(
                    key: ValueKey("reading_${isShowResult.toString()}"),
                    borderColor: cardColor,
                    vocab: vocab,
                    isMeaning: false,
                    controller: !isShowResult
                        ? _readingController
                        : _readingControllerTemp,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      _meaningControllerTemp.text = vocab.meaning;
                      _readingControllerTemp.text = vocab.reading;

                      String meaningValue =
                          _meaningController.text.toLowerCase();
                      String readingValue =
                          _readingController.text.toLowerCase();

                      bool isMeaningCorrect =
                          vocab.meaning.toLowerCase().contains(meaningValue) &&
                              meaningValue.isNotEmpty;
                      bool isReadingCorrect =
                          vocab.reading.toLowerCase().contains(readingValue) &&
                              readingValue.isNotEmpty;

                      if (isFirstTap) {
                        setState(() {
                          isFirstTap = false;
                          isShowResult = true;
                          cardColor = (isReadingCorrect && isMeaningCorrect)
                              ? const Color(0xFF009903)
                              : const Color(0xFFB10020);
                        });
                      } else {
                        if (isReadingCorrect && isMeaningCorrect) {
                          learningLevelUpgrade(vocab);
                          updateState(vocab, false);
                          deleteFromLessonQueue(vocab, false);
                          widget.vocabList.removeAt(0);
                          if (widget.vocabList.isNotEmpty) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VocabReviewCard(
                                        vocabList: widget.vocabList,
                                        currentKanjiIndex: 0,
                                        isLesson: widget.isLesson,
                                      )),
                            );
                          } else {
                            /*Navigator.popUntil(
                                context, (route) => route.isFirst);
                            DefaultTabController.of(context).animateTo(0);*/
                            if (widget.isLesson) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('last_vocab_lesson_login',
                                  DateTime.now().toIso8601String());
                            }
                            var routeDirection =
                                widget.isLesson ? '/lessons' : '/reviews';
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              routeDirection,
                              (route) => false,
                            );
                          }
                        } else {
                          var failedToRememberVocab = widget.vocabList[0];
                          learningLevelDowngrade(failedToRememberVocab);
                          widget.vocabList.removeAt(0);
                          widget.vocabList.add(failedToRememberVocab);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VocabReviewCard(
                                      vocabList: widget.vocabList,
                                      currentKanjiIndex: 0,
                                      isLesson: widget.isLesson,
                                    )),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: CustomNormalButton(
                          name: isFirstTap ? "See Results" : "Next",
                          mainColor: const Color(0xFFAD56C4),
                          secondColor: const Color(0xFFFFFFFF)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
