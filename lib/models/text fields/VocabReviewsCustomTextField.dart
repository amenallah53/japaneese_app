import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/vocab.dart';

// ignore: must_be_immutable
class VocabReviewsCustomTextField extends StatelessWidget {
  final Vocab vocab;
  final bool isMeaning;
  Color borderColor;
  bool? isMeaningCorrect;
  bool? isReadingCorrect;
  final TextEditingController? controller;

  VocabReviewsCustomTextField({
    super.key,
    required this.vocab,
    required this.isMeaning,
    required this.borderColor,
    this.isMeaningCorrect,
    this.isReadingCorrect,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: const Color(0xFFFBFBFB),
        focusColor: const Color(0xFFFBFBFB),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: isMeaning ? 'Your response...' : '答え...',
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
