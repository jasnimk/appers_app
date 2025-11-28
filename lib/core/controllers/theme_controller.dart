import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'theme_mode';

  // Use ThemeMode.system to follow device theme by default
  final _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  bool get isDarkMode => _themeMode.value == ThemeMode.dark;
  bool get isSystemMode => _themeMode.value == ThemeMode.system;
  bool get isLightMode => _themeMode.value == ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? 0; // 0 = system, 1 = light, 2 = dark
      _themeMode.value = ThemeMode.values[themeIndex];
      Get.changeThemeMode(_themeMode.value);
    } catch (e) {
      print('Error loading theme preference: $e');
      _themeMode.value = ThemeMode.system;
    }
  }

  Future<void> _saveThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, _themeMode.value.index);
    } catch (e) {
      print('Error saving theme preference: $e');
    }
  }

  void toggleTheme() {
    if (_themeMode.value == ThemeMode.light) {
      _themeMode.value = ThemeMode.dark;
    } else if (_themeMode.value == ThemeMode.dark) {
      _themeMode.value = ThemeMode.system;
    } else {
      _themeMode.value = ThemeMode.light;
    }
    Get.changeThemeMode(_themeMode.value);
    _saveThemePreference();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
    _saveThemePreference();
  }

  void setDarkMode(bool value) {
    _themeMode.value = value ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(_themeMode.value);
    _saveThemePreference();
  }

  void setSystemMode() {
    _themeMode.value = ThemeMode.system;
    Get.changeThemeMode(ThemeMode.system);
    _saveThemePreference();
  }
}
