import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeService {
  static const _boxName = 'settings';
  static const _keyThemeMode = 'themeMode';

  static late final Box _settingsBox;
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  static Future<void> init() async {
    _settingsBox = await Hive.openBox(_boxName);
    final savedTheme = _settingsBox.get(_keyThemeMode, defaultValue: 'light');
    themeNotifier.value = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggleTheme() {
    final isDark = themeNotifier.value == ThemeMode.dark;
    themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
    _settingsBox.put(_keyThemeMode, themeNotifier.value == ThemeMode.dark ? 'dark' : 'light');
  }
}
