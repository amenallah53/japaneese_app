import 'package:flutter/material.dart';
import 'package:japaneese_app/classes/kanji.dart';
import 'package:japaneese_app/classes/vocab.dart';
import 'package:japaneese_app/pages/kanji_vocab_search_results.dart';

class CustomSearchTextField extends StatefulWidget {
  final List<Vocab> totalVocabs;
  final List<Kanji> totalKanjis;
  const CustomSearchTextField(
      {super.key, required this.totalVocabs, required this.totalKanjis});

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      hintText: "Enter kanji, vocabulary by characters or meaning ",
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      backgroundColor: WidgetStateProperty.all(Color(0xFFFFFFFF)),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 16.0),
      ),
      onTap: () {},
      onChanged: (String query) {
        print(query);
      },
      onSubmitted: (_) {
        String searchText = _controller.text.trim();

        bool _searchByMeaning = isAlphabetical(searchText)
            ? true
            : isAllJapanese(searchText)
                ? false
                : true; // default to meaning search if mixed or unknown input

        List<Kanji> inFoundKanjis = searchText.isEmpty
            ? []
            : widget.totalKanjis
                .where((kanji) => _searchByMeaning
                    ? (kanji.meaning
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    : kanji.kanji.contains(searchText))
                .toList();

        List<Vocab> inFoundVocabs = searchText.isEmpty
            ? []
            : widget.totalVocabs
                .where((vocab) => _searchByMeaning
                    ? (vocab.meaning
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    : vocab.word.contains(searchText))
                .toList();

        print("I've found kanjis : $inFoundKanjis");
        print("I've found vocabs : $inFoundVocabs");

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => KanjiVocabSearchResults(
                    listKanji: inFoundKanjis,
                    listVocab: inFoundVocabs,
                    searchedString: searchText)));
      },
      leading: const Icon(Icons.search),
    );
  }

  bool isAlphabetical(String s) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(s);
  }

  bool isAllJapanese(String s) {
    return RegExp(r'^[\u3040-\u30FF\u4E00-\u9FAF]+$').hasMatch(s);
  }
}













/*import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

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
*/