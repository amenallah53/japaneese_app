import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/pages/kanji_vocab_progress_stats.dart';

class LearningProgressStat extends StatefulWidget {
  final Color mainColor;
  final Color secondColor;
  final String name;
  final String nameInJapaneese;
  final List<Vocab>? totalVocabs;
  final List<Kanji>? totalKanjis;
  final List<Vocab>? unlockedVocabs;
  final List<Kanji>? unlockedKanjis;
  final VoidCallback? onTap;

  const LearningProgressStat({
    super.key,
    required this.mainColor,
    required this.secondColor,
    required this.name,
    required this.nameInJapaneese,
    this.onTap,
    this.totalVocabs,
    this.totalKanjis,
    this.unlockedVocabs,
    this.unlockedKanjis,
  });

  @override
  State<LearningProgressStat> createState() => _LearningProgressStatState();
}

class _LearningProgressStatState extends State<LearningProgressStat>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _colorAnimation = ColorTween(
      begin: widget.mainColor,
      end: /*widget.mainColor.withOpacity(0.75)*/ darken(widget.mainColor, 15),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var unlockedList = widget.mainColor == Color(0xFFFF8DA1)
        ? widget.unlockedKanjis
        : widget.unlockedVocabs;
    var totalList = widget.mainColor == Color(0xFFFF8DA1)
        ? widget.totalKanjis
        : widget.totalVocabs;
    final double progressValue =
        totalList!.isEmpty ? 0 : unlockedList!.length / totalList.length;

    return GestureDetector(
      onTap: () {
        var iskanji = widget.name == "Kanji" ? true : false;
        var totalCount = widget.name == "Kanji"
            ? widget.totalKanjis!.length
            : widget.totalVocabs!.length;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => KanjiVocabProgressStats(
                    isKanji: iskanji,
                    nbreTotal: totalCount,
                    listKanji: iskanji ? widget.unlockedKanjis : [],
                    listVocab: iskanji ? [] : widget.unlockedVocabs,
                  )),
        );
      },
      onTapDown: (_) {
        _controller.forward();
        widget.onTap?.call();
      },
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.25),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: widget.secondColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.nameInJapaneese,
                    style: TextStyle(
                      color: widget.mainColor,
                      fontFamily: "Poppins",
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          letterSpacing: widget.name == "Kanji" ? 3 : 0,
                          color: widget.secondColor,
                          fontFamily: "Poppins",
                          fontSize: widget.name == "Kanji" ? 30 : 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progressValue,
                              minHeight: 8,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              color: const Color(0xFF7A4EFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${unlockedList!.length}/${totalList.length}",
                            style: TextStyle(
                              color: widget.secondColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Darken a color by [percent] amount (100 = black)
// ........................................................
Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
      (c.blue * f).round());
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
