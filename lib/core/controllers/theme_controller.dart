import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Use ThemeMode.system to follow device theme by default
  final _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  bool get isDarkMode => _themeMode.value == ThemeMode.dark;
  bool get isSystemMode => _themeMode.value == ThemeMode.system;

  @override
  void onInit() {
    super.onInit();
    // Default to system theme on startup
    _themeMode.value = ThemeMode.system;
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
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
  }

  void setDarkMode(bool value) {
    _themeMode.value = value ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(_themeMode.value);
  }

  void setSystemMode() {
    _themeMode.value = ThemeMode.system;
    Get.changeThemeMode(ThemeMode.system);
  }
}
