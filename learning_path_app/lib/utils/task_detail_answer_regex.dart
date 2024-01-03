import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextSpan getStyledAnswer(String answer) {
  final tripleAsterisksRegex = RegExp(r'\#\#\#(.+?)\#\#\#');
  final doubleAsterisksRegex = RegExp(r'(?<!\*)\*\*(.+?)\*\*(?!\*)');

  List<TextSpan> segments = [];
  while (answer.isNotEmpty) {
    final tripleMatch = tripleAsterisksRegex.firstMatch(answer);
    final doubleMatch = doubleAsterisksRegex.firstMatch(answer);

    RegExpMatch? earliestMatch;
    if (tripleMatch != null &&
        (doubleMatch == null || tripleMatch.start < doubleMatch.start)) {
      earliestMatch = tripleMatch;
    } else if (doubleMatch != null) {
      earliestMatch = doubleMatch;
    }

    if (earliestMatch != null && earliestMatch.start > 0) {
      segments.add(TextSpan(text: answer.substring(0, earliestMatch.start)));
    }

    if (earliestMatch == tripleMatch && tripleMatch != null) {
      segments.add(TextSpan(
        text: tripleMatch.group(1),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ));
      answer = answer.substring(tripleMatch.end);
    } else if (earliestMatch == doubleMatch && doubleMatch != null) {
      segments.add(TextSpan(
        text: doubleMatch.group(1),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
      answer = answer.substring(doubleMatch.end);
    }

    if (earliestMatch == null) {
      segments.add(TextSpan(text: answer));
      break;
    }
  }

  return TextSpan(
    children: segments,
    style: GoogleFonts.openSans(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      height: 1.5,
    ),
  );
}
