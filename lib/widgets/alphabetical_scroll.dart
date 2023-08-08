import 'package:flutter/material.dart';

class AlphabeticalScroll extends StatefulWidget {
  final List<String> letters;
  final Function(String) onLetterTap;

  AlphabeticalScroll({required this.letters, required this.onLetterTap});

  @override
  _AlphabeticalScrollState createState() => _AlphabeticalScrollState();
}

class _AlphabeticalScrollState extends State<AlphabeticalScroll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.letters.length,
        itemBuilder: (context, index) {
          final letter = widget.letters[index];
          return ListTile(
            title: Center(child: Text(letter)),
            onTap: () {
              widget.onLetterTap(letter);
            },
          );
        },
      ),
    );
  }
}
