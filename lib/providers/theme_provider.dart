import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoading = true;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;
  bool get isLoading => _isLoading;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _isLoading = true;
    notifyListeners();

    final isDark = await StorageService.isDarkMode();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await StorageService.saveDarkMode(_themeMode == ThemeMode.dark);
    notifyListeners();
  }
}
