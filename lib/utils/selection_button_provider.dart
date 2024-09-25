// utils/selection_button_provider.dart
import 'package:flutter/material.dart';

class SelectionButtonProvider extends ChangeNotifier {
  int _selectedButtonIndex = 0;

  int get selectedButtonIndex => _selectedButtonIndex;

  void selectButton(int index) {
    _selectedButtonIndex = index;
    notifyListeners();
  }
}
