class Kana {
  final String kana;
  final String romanjiReading;
  final String typeColumn;
  final int? correctCounter;
  final String? srsStageId;

  Kana(
      {required this.kana,
      required this.romanjiReading,
      required this.typeColumn,
      this.correctCounter,
      this.srsStageId});

  Map<String, dynamic> toMap() {
    return {
      'kana': kana,
      'romanji_reading': romanjiReading,
      'type_column': typeColumn,
      'correct_counter': correctCounter,
      'srs_stage_id': srsStageId,
    };
  }

  factory Kana.fromMap(Map<String, dynamic> map) {
    return Kana(
        kana: map['kana'] as String,
        romanjiReading: map['romanji_reading'] as String,
        typeColumn: map['type_column'] as String,
        correctCounter: map['correct_counter'] as int? ?? 0,
        srsStageId: map['srs_stage_id'] as String? ?? '');
  }

  @override
  String toString() {
    // TODO: implement toString
    return '';
  }
}
