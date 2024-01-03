String getFormattedTitle(String question, {String? category}) {
  if (question.contains("Total")) {
    RegExp patternTask = RegExp(r'Task \d+');
    var matchTaskNumber = patternTask.firstMatch(question);

    if (category == "Academic") {
      return "Academic ${(matchTaskNumber?.group(0) ?? '').trim()}";
    }

    return (matchTaskNumber?.group(0) ?? '').trim();
  }

  if (question == "Tips") {
    return "Tips";
  }

  RegExp pattern = RegExp(r'Task \d+\) ([^(]+)');
  RegExp patternTask = RegExp(r'Task \d+');
  var matchTaskNumber = patternTask.firstMatch(question);
  var match = pattern.firstMatch(question);

  return (category != null && (category == "General" || category == "Academic")
          ? category + " "
          : "") +
      (match?.group(1)?.trim() ?? (matchTaskNumber?.group(0) ?? '').trim());
}
