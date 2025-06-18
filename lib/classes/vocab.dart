import 'package:japaneese_app/classes/character.dart';

class Vocab extends Character {
  final String word;
  final String reading;

  Vocab(
      {required super.id,
      required super.meaning,
      super.state,
      super.nextReviewTime,
      super.correctCounter,
      super.srsStageId,
      super.jlptLevel,
      required this.word,
      required this.reading});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'state': state,
      'next_review_time': nextReviewTime?.toIso8601String(),
      'correct_counter': correctCounter,
      'srs_stage_id': srsStageId,
      'jlpt_level': jlptLevel,
      'meaning': meaning,
      'reading': reading,
    };
  }

  factory Vocab.fromMap(Map<String, dynamic> map) {
    return Vocab(
      id: map['id'] as int,
      meaning: map['meaning'] as String,
      state: map['state'] as String? ?? '',
      nextReviewTime: map['next_review_time'] != null
          ? DateTime.parse(map['next_review_time'] as String)
          : null,
      correctCounter: map['correct_counter'] as int? ?? 0,
      srsStageId: map['srs_stage_id'] as String? ?? '',
      jlptLevel: map['jlpt_level'] as String? ?? '',
      word: map['word'] as String? ?? '?',
      reading: map['reading'] as String? ?? '',
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return ''' "word : $word , meaning : $meaning , reading : $reading ,
    jlpt_level : $jlptLevel , srs_stage_id : $srsStageId , correct_counter : $correctCounter ,
    next_review_time : $nextReviewTime " ''';
  }
}
