
enum ThemeModeOption { light, dark }

// class ThemeModeNotifier extends ChangeNotifier {
//   ThemeModeOption _themeMode = ThemeModeOption.light;

//   ThemeModeOption get themeMode => _themeMode;

//   void toggleThemeMode() {
//     _themeMode = _themeMode == ThemeModeOption.light
//         ? ThemeModeOption.dark
//         : ThemeModeOption.light;
//     notifyListeners();
//   }
// }

// final themeModeProvider = ChangeNotifierProvider<ThemeModeNotifier>((ref) {
//   return ThemeModeNotifier();
// });
