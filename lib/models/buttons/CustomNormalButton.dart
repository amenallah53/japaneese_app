import 'package:flutter/material.dart';

class CustomNormalButton extends StatelessWidget {
  final String name;
  final Color mainColor;
  final Color secondColor;
  const CustomNormalButton(
      {super.key,
      required this.name,
      required this.mainColor,
      required this.secondColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              color: secondColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
          ),
          const SizedBox(width: 0),
          Icon(
            Icons.chevron_right,
            color: secondColor,
            size: 18,
          ),
        ],
      ),
    );
  }
}
