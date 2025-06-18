import 'package:japaneese_app/classes/character.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

final dbName = 'kanji_app.db';

Future<Database> getDatabase() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, dbName);

  bool exists = await databaseExists(path);

  if (!exists) {
    ByteData data = await rootBundle.load('assets/db/$dbName');
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Verify we got data
    if (bytes.isEmpty) {
      throw Exception("Database file is empty!");
    }

    await File(path).writeAsBytes(bytes);

    // Verify the copied file
    File copiedFile = File(path);
    if (!await copiedFile.exists() || await copiedFile.length() == 0) {
      throw Exception("Failed to copy database!");
    }
    print(" Database successfully copied to $path");
  }

  // Open and verify
  Database db = await openDatabase(path);

  // DEBUG: List all tables for test
  /*List<Map> tables =
      await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
  print("Tables in database: $tables");*/

  return db;
}

Future<List<Kanji>> getLessonKanjis() async {
  final db = await getDatabase();
  try {
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('''SELECT * FROM lessons_kanji_queue''');

    print("bankai : ${maps}");

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      try {
        return Kanji.fromMap(maps[i]);
      } catch (e) {
        print('Error parsing kanji record ${maps[i]}: $e');
        return Kanji(
          id: -1,
          meaning: 'Invalid record',
          kanji: '?',
          onReading: '',
          kunReading: '',
        );
      }
    }).where((kanji) => kanji.id != -1).toList();
  } catch (e) {
    print("Database error: $e");
    return [];
  }
}

Future<List<Vocab>> getLessonVocabs() async {
  final db = await getDatabase();
  try {
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('''SELECT * FROM lessons_vocab_queue''');

    print("bankai : ${maps}");

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      try {
        return Vocab.fromMap(maps[i]);
      } catch (e) {
        print('Error parsing vocab record ${maps[i]}: $e');
        return Vocab(
          id: -1,
          word: '?',
          meaning: 'Invalid record',
          reading: '',
        );
      }
    }).where((vocab) => vocab.id != -1).toList();
  } catch (e) {
    print("Database error: $e");
    return [];
  }
}

Future<void> insertIntoLessonKanjisQueue(int n) async {
  final db = await getDatabase();

  // Get last ID or default to 0 if empty
  int lastId = 0;
  final lastLessonKanjiOnQueue = await db.rawQuery('''
    SELECT id FROM lessons_kanji_queue 
    ORDER BY id DESC 
    LIMIT 1
  ''');

  if (lastLessonKanjiOnQueue.isNotEmpty) {
    lastId = lastLessonKanjiOnQueue[0]["id"] as int;
  }

  // Fetch new kanjis
  final listMissedKanji = await db.rawQuery('''
    SELECT id, kanji, meaning, on_reading, kun_reading 
    FROM kanji
    WHERE state = 'locked'
    AND id > ?
    ORDER BY id ASC
    LIMIT ?
  ''', [lastId, n]);

  // Insert new kanjis
  for (final kanji in listMissedKanji) {
    await db.rawInsert('''
      INSERT INTO lessons_kanji_queue
      (id, kanji, meaning, on_reading, kun_reading) 
      VALUES(?, ?, ?, ?, ?)
    ''', [
      kanji["id"],
      kanji["kanji"],
      kanji["meaning"],
      kanji["on_reading"],
      kanji["kun_reading"]
    ]);
  }

  print("Inserted ${listMissedKanji.length} new kanjis");
}

Future<void> insertIntoLessonVocabsQueue(int n) async {
  final db = await getDatabase();

  // Get last ID or default to 0 if empty
  int lastId = 0;
  final lastLessonVocabOnQueue = await db.rawQuery('''
    SELECT id FROM lessons_vocab_queue 
    ORDER BY id DESC 
    LIMIT 1
  ''');

  if (lastLessonVocabOnQueue.isNotEmpty) {
    lastId = lastLessonVocabOnQueue[0]["id"] as int;
  }

  // Fetch new vocabs
  final listNewVocabs = await db.rawQuery('''
    SELECT id, word, meaning, reading
    FROM vocabulary
    WHERE state = 'locked'
    AND id > ?
    ORDER BY id ASC
    LIMIT ?
  ''', [lastId, n]);

  // Insert new vocabs
  for (final vocab in listNewVocabs) {
    await db.rawInsert('''
      INSERT INTO lessons_vocab_queue
      (id, word, meaning, reading) 
      VALUES(?, ?, ?, ?)
    ''', [vocab["id"], vocab["word"], vocab["meaning"], vocab["reading"]]);
  }

  print("Inserted ${listNewVocabs.length} new vocabs");
}

Future<void> updateState(Character charac, bool isKanji) async {
  final db = await getDatabase();
  final tableName = isKanji ? 'kanji' : 'vocabulary';

  await db.rawUpdate('''
    UPDATE $tableName
    SET state = 'unlocked',
        correct_counter = ?,
        srs_stage_id = ?,
        next_review_time = ?
    WHERE id = ?
  ''', [
    charac.correctCounter,
    charac.srsStageId,
    charac.nextReviewTime!
        .toUtc()
        .toIso8601String()
        .substring(0, 19)
        .replaceFirst('T', ' '),
    charac.id
  ]);

  print("update !!");
}

Future<void> deleteFromLessonQueue(Character charac, bool isKanji) async {
  final db = await getDatabase();
  final tableName = isKanji ? 'lessons_kanji_queue' : 'lessons_vocab_queue';

  await db.rawDelete('''
    DELETE FROM $tableName
    WHERE id = ?
  ''', [charac.id]);

  print("delete !!");
}

void srsStageIdUpdate(Character charac, bool isWrong) {
  if (isWrong == true) {
    charac.srsStageId = "a1";
    charac.correctCounter = 0;
    return;
  }
  switch (charac.correctCounter) {
    case 1:
      charac.srsStageId = "a1";
      break;
    case 2:
      charac.srsStageId = "a2";
      break;
    case 3:
      charac.srsStageId = "a3";
      break;
    case 4:
      charac.srsStageId = "a4";
      break;
    case 5:
    case 6:
      charac.srsStageId = "g1";
      break;
    case 7:
    case 8:
      charac.srsStageId = "g2";
      break;
    case 9:
    case 10:
    case 11:
    case 12:
      charac.srsStageId = "m";
      break;
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 19:
    case 20:
      charac.srsStageId = "e";
      break;
    default:
      charac.srsStageId = "b";
  }
}

void newDateReviewUpdate(Character charac) {
  switch (charac.srsStageId) {
    case "a1":
      charac.nextReviewTime =
          DateTime.now().add(Duration(days: 1)); //  1 day from now
      break;
    case "a2":
      charac.nextReviewTime =
          DateTime.now().add(Duration(days: 2)); // 2 day from now
      break;
    case "a3":
      charac.nextReviewTime =
          DateTime.now().add(Duration(days: 4)); // 4 days from now
      break;
    case "a4":
      charac.nextReviewTime =
          DateTime.now().add(Duration(days: 7)); // a week from now
      break;
    case "g1":
      charac.nextReviewTime =
          DateTime.now().add(Duration(days: 14)); // 2 weeks from now
      break;
    case "g2":
      charac.nextReviewTime =
          DateTime.now().add(Duration(days: 30)); // a month from now
      break;
    case "m":
      charac.nextReviewTime =
          DateTime.now().add(Duration(days: 60)); // 2 months from now
      break;
    case "e":
      charac.nextReviewTime =
          DateTime.now().add(Duration(days: 120)); // 4 months from now
      break;
    case "b":
      charac.nextReviewTime = null;
      break;
    default:
  }
}

void learningLevelUpgrade(Character charac) {
  charac.correctCounter = charac.correctCounter! + 1;
  srsStageIdUpdate(charac, false);
  newDateReviewUpdate(charac);
}

void learningLevelDowngrade(Character charac) {
  if (charac.correctCounter! > 1) {
    charac.correctCounter = charac.correctCounter! - 1;
  }
  srsStageIdUpdate(charac, true);
  newDateReviewUpdate(charac);
}
