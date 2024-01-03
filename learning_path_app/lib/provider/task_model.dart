import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier {
  String _selectedTaskText = '';

  String get selectedTaskText => _selectedTaskText;

  void selectTask(String text) {
    _selectedTaskText = text;
    notifyListeners(); // Notify listeners about the change
  }
}
