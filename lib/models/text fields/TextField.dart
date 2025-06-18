import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search, /*color: Colors.grey,*/
        ),
        filled: true,
        fillColor: Color(0xFFFBFBFB),
        focusColor: Color(0xFFFBFBFB),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF385B94), width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF385B94), width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF385B94), width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Search for kanji or vocabulary',
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
