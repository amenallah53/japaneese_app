import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/database_connection/database_lessons.dart';

Future<List<Kanji>> getReviewKanjis() async {
  final db = await getDatabase();
  try {
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
        SELECT * 
        FROM kanji 
        WHERE next_review_time <= DATETIME('now')
        ''');

    print("shikai : ${maps}");

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

Future<List<Vocab>> getReviewVocabs() async {
  final db = await getDatabase();
  try {
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
        SELECT * 
        FROM vocabulary 
        WHERE next_review_time <= DATETIME('now')
    ''');

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

Future<int> kanjiVocabSrsStageCount(bool isKanji, String srsStage) async {
  final db = await getDatabase();
  try {
    var table = isKanji ? 'kanji' : 'vocabulary';
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT COUNT(*) as result
      FROM $table
      WHERE srs_stage_id LIKE ?
    ''', ['${srsStage}%']);

    if (maps.isEmpty) {
      return 0;
    }

    return maps[0]['result'] as int;
  } catch (e) {
    print("Database error: $e");
    return 0;
  }
}

Future<List<Kanji>> getAllKanji() async {
  final db = await getDatabase();
  try {
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT *
      FROM kanji
    ''', []);

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (index) {
      return Kanji.fromMap(maps[index]);
    });
  } catch (e) {
    print("Database error: $e");
    return [];
  }
}

Future<List<Kanji>> getUnlockedKanji() async {
  final db = await getDatabase();
  try {
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT *
      FROM kanji
      WHERE state = 'unlocked'
    ''', []);

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (index) {
      return Kanji.fromMap(maps[index]);
    });
  } catch (e) {
    print("Database error: $e");
    return [];
  }
}

Future<List<Vocab>> getAllVocabs() async {
  final db = await getDatabase();
  try {
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT *
      FROM vocabulary
    ''', []);

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (index) {
      return Vocab.fromMap(maps[index]);
    });
  } catch (e) {
    print("Database error: $e");
    return [];
  }
}

Future<List<Vocab>> getUnlockedVocab() async {
  final db = await getDatabase();
  try {
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT *
      FROM vocabulary
      WHERE state = 'unlocked'
    ''', []);

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (index) {
      return Vocab.fromMap(maps[index]);
    });
  } catch (e) {
    print("Database error: $e");
    return [];
  }
}
