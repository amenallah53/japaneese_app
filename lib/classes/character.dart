class Character {
  final int id;
  final String meaning;
  String? state;
  DateTime? nextReviewTime;
  int? correctCounter;
  String? srsStageId;
  final String? jlptLevel;

  Character({
    required this.id,
    required this.meaning,
    this.state,
    this.nextReviewTime,
    this.correctCounter,
    this.srsStageId,
    this.jlptLevel,
  });
}
