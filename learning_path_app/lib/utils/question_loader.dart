import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:learning_path_app/models/question_model.dart';

class QuestionLoader {
  static Future<List<QuestionModel>> loadQuestions(String jsonPath) async {
    final String response = await rootBundle.loadString(jsonPath);
    final List<dynamic> data = json.decode(response);
    return data.map((json) => QuestionModel.fromJson(json)).toList();
  }
}
