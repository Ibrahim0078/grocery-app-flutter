import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  int _currentTabIndex = 0;
  bool _isInitialized = false;
  String _appName = 'Grocery Store';

  // Getters
  int get currentTabIndex => _currentTabIndex;
  bool get isInitialized => _isInitialized;
  String get appName => _appName;

  // Set current tab index for bottom navigation
  void setTabIndex(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  // Initialize app
  Future<void> initializeApp() async {
    if (_isInitialized) return;

    try {
      // Simulate app initialization (you can add real initialization logic here)
      await Future.delayed(const Duration(milliseconds: 500));

      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing app: $e');
    }
  }

  // Reset app state
  void reset() {
    _currentTabIndex = 0;
    _isInitialized = false;
    notifyListeners();
  }

  // Tab navigation methods
  void goToHome() => setTabIndex(0);
  void goToCategories() => setTabIndex(1);
  void goToSearch() => setTabIndex(2);
  void goToCart() => setTabIndex(3);
}
