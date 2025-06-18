import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavigationVocabButton extends StatefulWidget {
  String name;
  final Color mainColor;
  final Color secondColor;
  CustomNavigationVocabButton({
    super.key,
    required this.name,
    required this.mainColor,
    required this.secondColor,
  });

  @override
  State<CustomNavigationVocabButton> createState() =>
      _CustomNavigationButtonState();
}

class _CustomNavigationButtonState extends State<CustomNavigationVocabButton> {
  double borderSize = 10;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: widget.mainColor,
      // Position the menu below the button
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      onOpened: () {
        setState(() {
          widget.name = "単語";
          borderSize = 0;
        });
      },
      onCanceled: () {
        setState(() {
          widget.name = "vocab";
          borderSize = 10;
        });
      },

      // Constrain the popup size
      constraints: BoxConstraints(
        minWidth: 80,
        maxWidth: 80,
      ),

      // Make the button more compact
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          constraints: BoxConstraints(
            minWidth: 80,
          ),
          decoration: BoxDecoration(
            color: widget.secondColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderSize),
              bottomRight: Radius.circular(borderSize),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Center(
            heightFactor: 1,
            child: Text(
              widget.name,
              style: TextStyle(
                color: widget.mainColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
          )),

      // Menu items
      itemBuilder: (BuildContext context) {
        return kanjiVocabPopUpMenu(context);
      },

      onSelected: (String value) {
        print('Selected: $value');
        setState(() {
          widget.name = "vocab";
          borderSize = 10;
        });
      },
    );
  }
}

List<PopupMenuItem<String>> kanjiVocabPopUpMenu(BuildContext context) {
  return List.generate(10, (i) {
    return PopupMenuItem<String>(
      value: 'level ${i + 1}',
      height: 36,
      child: Column(
        children: [
          Center(
            heightFactor: 1,
            child: Text('level ${i + 1}',
                style: TextStyle(
                    letterSpacing: 1,
                    fontFamily: "Poppins",
                    fontSize: 13,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  });
}
