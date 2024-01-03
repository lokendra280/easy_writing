import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_path_app/models/question_model.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomepageProvider extends ChangeNotifier {
  HomepageProvider() {
    loadSubscriptionStatus();
  }
  final Map<String, List<QuestionModel>> _questions = {};
  final Map<String, List<QuestionModel>> _bookmarks = {};
  final Map<String, List<QuestionModel>> _markedAsRead = {};
  bool _isSubscribed = false;
  final Map<String, Map<int, int>> _originalIndices = {};

  bool get isSubscribed => _isSubscribed;

  Future<void> checkAndUpdateSubscriptionStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      _isSubscribed = customerInfo.entitlements.active.isNotEmpty;
      await updateSubscriptionStatus(_isSubscribed);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> loadQuestions(String path, String category) async {
    if (_questions.containsKey(path) && _questions[path]!.isNotEmpty) {
      return;
    }

    String response;
    if (category == "General") {
      response = await rootBundle
          .loadString('assets/model_answers_json/${path}Writing.json');
    } else {
      response =
          await rootBundle.loadString('assets/Academic/${path}Writing.json');
    }

    List<dynamic> jsonData = json.decode(response);

    List<QuestionModel> loadedQuestions =
        jsonData.map((jsonItem) => QuestionModel.fromJson(jsonItem)).toList();

    if (!_isSubscribed) {
      loadedQuestions = loadedQuestions.take(5).toList();
    }

    // Store all questions temporarily
    _questions[path] = loadedQuestions;

    // Load persistent data
    await loadPersistentData(path);

    // Filter out bookmarked and read questions
    _questions[path] = (_questions[path] ?? []).where((q) {
      return !(_bookmarks[path]?.any((bq) => bq.srNo == q.srNo) ?? false) &&
          !(_markedAsRead[path]?.any((rq) => rq.srNo == q.srNo) ?? false);
    }).toList();

    notifyListeners();
  }

  Future<void> loadPersistentData(String path) async {
    final prefs = await SharedPreferences.getInstance();

    // Load bookmarks
    List<String> bookmarkedIds = prefs.getStringList('bookmarks_$path') ?? [];
    _bookmarks[path] = _questions[path]
            ?.where((q) => bookmarkedIds.contains(q.srNo.toString()))
            .toList() ??
        [];

    // Load marked as read
    List<String> readIds = prefs.getStringList('read_$path') ?? [];
    _markedAsRead[path] = _questions[path]
            ?.where((q) => readIds.contains(q.srNo.toString()))
            .toList() ??
        [];

    // Re-filter _questions to remove bookmarked or read questions
    _questions[path] = (_questions[path] ?? []).where((q) {
      return !(_bookmarks[path]?.any((bq) => bq.srNo == q.srNo) ?? false) &&
          !(_markedAsRead[path]?.any((rq) => rq.srNo == q.srNo) ?? false);
    }).toList();

    notifyListeners();
  }

  Future<void> toggleBookmark(String path, QuestionModel question) async {
    _bookmarks[path] ??= [];

    if (_bookmarks[path]!.contains(question)) {
      _bookmarks[path]!.remove(question);
      if (!(_markedAsRead[path]?.contains(question) ?? false)) {
        _reInsertQuestion(path, question);
      }
    } else {
      _bookmarks[path]!.add(question);
      _questions[path]?.remove(question);
    }

    await _saveToPreferences(path, 'bookmarks', _bookmarks[path]!);
    notifyListeners();
  }

  Future<void> toggleMarkAsRead(String path, QuestionModel question) async {
    _markedAsRead[path] ??= [];

    if (_markedAsRead[path]!.contains(question)) {
      _markedAsRead[path]!.remove(question);
      if (!(_bookmarks[path]?.contains(question) ?? false)) {
        _reInsertQuestion(path, question);
      }
    } else {
      _markedAsRead[path]!.add(question);
      _questions[path]?.remove(question);
    }

    await _saveToPreferences(path, 'read', _markedAsRead[path]!);
    notifyListeners();
  }

  void _reInsertQuestion(String path, QuestionModel question) {
    int originalIndex =
        _originalIndices[path]?[question.srNo] ?? _questions[path]?.length ?? 0;
    _questions[path]?.insert(originalIndex, question);
  }

  Future<void> _saveToPreferences(
      String path, String key, List<QuestionModel> questions) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = questions.map((q) => q.srNo.toString()).toList();
    await prefs.setStringList('${key}_$path', ids);
  }

  List<QuestionModel> getBookmarks(String path) => _bookmarks[path] ?? [];

  List<QuestionModel> getMarkedAsRead(String path) => _markedAsRead[path] ?? [];

  List<QuestionModel> getQuestions(String path) => _questions[path] ?? [];

  Future<void> updateSubscriptionStatus(bool status) async {
    _isSubscribed = status;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSubscribed', _isSubscribed);
    notifyListeners();
  }

  Future<void> loadSubscriptionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isSubscribed = prefs.getBool('isSubscribed') ?? false;
    notifyListeners();
  }
}
