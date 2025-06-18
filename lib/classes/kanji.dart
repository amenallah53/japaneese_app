import 'package:japaneese_app/classes/character.dart';

class Kanji extends Character {
  final String kanji;
  final String onReading;
  final String kunReading;

  Kanji({
    required super.id,
    required super.meaning,
    super.state,
    super.nextReviewTime,
    super.correctCounter,
    super.srsStageId,
    super.jlptLevel,
    required this.kanji,
    required this.onReading,
    required this.kunReading,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meaning': meaning,
      'state': state,
      'next_review_time': nextReviewTime?.toIso8601String(),
      'correct_counter': correctCounter,
      'srs_stage_id': srsStageId,
      'jlpt_level': jlptLevel,
      'kanji': kanji,
      'on_reading': onReading,
      'kun_reading': kunReading
    };
  }

  factory Kanji.fromMap(Map<String, dynamic> map) {
    return Kanji(
      id: map['id'] as int,
      meaning: map['meaning'] as String,
      state: map['state'] as String? ?? '',
      nextReviewTime: map['next_review_time'] != null
          ? DateTime.parse(map['next_review_time'] as String)
          : null,
      correctCounter: map['correct_counter'] as int? ?? 0,
      srsStageId: map['srs_stage_id'] as String? ?? '',
      jlptLevel: map['jlpt_level'] as String? ?? '',
      kanji: map['kanji'] as String? ?? '?',
      onReading: map['on_reading'] as String? ?? '',
      kunReading: map['kun_reading'] as String? ?? '',
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return ''' "kanji : $kanji , meaning : $meaning , on_reading : $onReading , kun_reading : $kunReading ,
    jlpt_level : $jlptLevel , srs_stage_id : $srsStageId , correct_counter : $correctCounter ,
    next_review_time : $nextReviewTime " ''';
  }
}
