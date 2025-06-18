import 'package:flutter/material.dart';

class SrsStageStat extends StatefulWidget {
  final Color mainColor;
  final Color secondColor;
  final String srsStageLevel;
  final Future<int> Function() vocabCounter;
  final Future<int> Function() kanjiCounter;
  const SrsStageStat({
    super.key,
    required this.mainColor,
    required this.secondColor,
    required this.srsStageLevel,
    required this.vocabCounter,
    required this.kanjiCounter,
  });

  @override
  State<SrsStageStat> createState() => _SrsStageStatState();
}

class _SrsStageStatState extends State<SrsStageStat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 200,
      decoration: BoxDecoration(
        color: widget.mainColor,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.srsStageLevel,
            style: TextStyle(
              color: widget.secondColor,
              fontFamily: "Poppins",
              fontSize: widget.srsStageLevel != "Enlightened" ? 20 : 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildStatRow("漢字", widget.kanjiCounter),
          _buildStatRow("単語", widget.vocabCounter),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, Future<int> Function() counterFunction) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.secondColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: widget.mainColor,
              fontFamily: "Poppins",
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          FutureBuilder<int>(
            future: counterFunction(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              } else if (snapshot.hasError) {
                return const Icon(Icons.error, color: Colors.red);
              } else {
                return Text(
                  "${snapshot.data}",
                  style: TextStyle(
                    color: widget.mainColor,
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
