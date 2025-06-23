import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/database_connection/database_lessons.dart';
import 'package:japaneese_app/database_connection/database_reviews.dart';
import 'package:japaneese_app/pages/home_page.dart';
//import 'package:japaneese_app/pages/kanji_vocab_progress_stats.dart';
import 'package:japaneese_app/pages/lessons_page.dart';
import 'package:japaneese_app/pages/reviews_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int currentPageIndex = 0;
  List<Kanji>? kanjiLessonsList;
  List<Vocab>? vocabLessonsList;
  List<Kanji>? kanjiReviewsList;
  List<Vocab>? vocabReviewsList;
  List<Vocab> totalVocabList = [];
  List<Kanji> totalKanjiList = [];
  List<Vocab> unlockedVocabList = [];
  List<Kanji> unlockedKanjiList = [];

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  // Call this to switch tabs properly
  void switchToTab(int index) {
    setState(() => currentPageIndex = index);
    // Pop everything until home (keeps bottom bar)
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  Future<void> _initializeApp() async {
    _loadTotalKanjiVocabs();
    _loadUnlockedKanjiVocabs();
    _loadLessonKanjis();
    _loadLessonVocabs();
    _loadReviewKanjis();
    _loadReviewVocabs();

    // Once everything’s loaded, remove the splash
    FlutterNativeSplash.remove();
  }

  Future<void> _loadTotalKanjiVocabs() async {
    var kanjis = await getAllKanji();
    var vocabs = await getAllVocabs();
    setState(() {
      totalKanjiList = kanjis;
      totalVocabList = vocabs;
      print(
          "dangai ichigo ${totalKanjiList.length} , ${totalVocabList.length}");
    });
  }

  Future<void> _loadUnlockedKanjiVocabs() async {
    var kanjis = await getUnlockedKanji();
    var vocabs = await getUnlockedVocab();
    setState(() {
      unlockedKanjiList = kanjis;
      unlockedVocabList = vocabs;
      print(
          "butterflyzen ${unlockedKanjiList.length} , ${unlockedVocabList.length}");
    });
  }

  Future<void> _loadLessonKanjis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastKanjiLessonLogin = prefs.getString('last_kanji_lesson_login');

    bool shouldShowLesson;

    if (lastKanjiLessonLogin == null) {
      // No saved date, so show lesson
      shouldShowLesson = true;
    } else {
      DateTime lastLoginTime = DateTime.parse(lastKanjiLessonLogin);
      Duration difference = DateTime.now().difference(lastLoginTime);

      // If it's been more than a day, show lesson
      shouldShowLesson = difference > Duration(days: 1);
    }

    if (shouldShowLesson) {
      var kanjis = await getLessonKanjis();
      print("Current queue length: ${kanjis.length}");
      if (kanjis.isEmpty) {
        try {
          await insertIntoLessonKanjisQueue(10);
          // Refresh the list after insertion
          kanjis = await getLessonKanjis();
          print("Updated queue length: ${kanjis.length}");
        } catch (e) {
          print("Error updating queue: $e");
        }
      }

      setState(() {
        kanjiLessonsList = kanjis;
      });
    } else {
      setState(() {
        kanjiLessonsList = [];
      });
    }
  }

  Future<void> _loadReviewKanjis() async {
    var kanjis = await getReviewKanjis();
    /*final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        '''SELECT next_review_time,DATETIME('now') as now FROM kanji LIMIT 20''');
    print("isco :  ${maps[0]["next_review_time"]} , ${maps[0]["now"]}");*/

    print("Current queue length: ${kanjis.length}");
    setState(() {
      kanjiReviewsList = kanjis;
    });
  }

  Future<void> _loadLessonVocabs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastVocabLessonLogin = prefs.getString('last_vocab_lesson_login');

    bool shouldShowLesson;

    // Ensure unlocked lists are loaded first
    await _loadUnlockedKanjiVocabs();

    bool hasEnoughKanji =
        unlockedKanjiList.length - unlockedVocabList.length > 0;

    if (lastVocabLessonLogin == null) {
      // No saved date, so show lesson
      shouldShowLesson = true;
    } else {
      DateTime lastLoginTime = DateTime.parse(lastVocabLessonLogin);
      Duration difference = DateTime.now().difference(lastLoginTime);

      // If it's been more than a day, show lesson
      shouldShowLesson = difference > Duration(days: 1) && hasEnoughKanji;
    }

    if (shouldShowLesson) {
      var vocabs = await getLessonVocabs();
      print("Current queue length: ${vocabs.length}");

      if (vocabs.isEmpty) {
        try {
          await insertIntoLessonVocabsQueue(10);
          // Refresh the list after insertion
          vocabs = await getLessonVocabs();
          print("Updated queue length: ${vocabs.length}");
        } catch (e) {
          print("Error updating queue: $e");
        }
      }

      setState(() {
        vocabLessonsList = vocabs;
      });
    } else {
      setState(() {
        vocabLessonsList = [];
      });
    }
  }

  Future<void> _loadReviewVocabs() async {
    var vocabs = await getReviewVocabs();
    print("Current queue length: ${vocabs.length}");
    setState(() {
      vocabReviewsList = vocabs;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("nomber ${totalVocabList.length} ; ${totalKanjiList.length}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(
        totalVocabs: totalVocabList,
        totalKanjis: totalKanjiList,
        unlockedVocabs: unlockedVocabList,
        unlockedKanjis: unlockedKanjiList,
      ),
      routes: {
        '/home': (context) => HomePage(
              totalVocabs: totalVocabList,
              totalKanjis: totalKanjiList,
              unlockedVocabs: unlockedVocabList,
              unlockedKanjis: unlockedKanjiList,
            ),
        '/lessons': (context) => LessonsPage(
              kanjiList: kanjiLessonsList,
              vocabList: vocabLessonsList,
            ),
        '/reviews': (context) => ReviewsPage(
              kanjiList: kanjiReviewsList,
              vocabList: vocabReviewsList,
            ),
        //'/settings': (context) => Placeholder(),
        //'/kanjivocabstats': (context) => KanjiVocabProgressStats(),
      },
    );
  }
}
