import 'package:flutter/material.dart';
import 'package:flutterapp/data/constants.dart';
import 'package:flutterapp/data/notifiers.dart';
import 'package:flutterapp/views/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initThemeMode();
    super.initState();
  }

  void initThemeMode() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? themMode = prefs.getBool(KConstants.themeModeKey);
    isDarkModeNotifier.value = themMode ?? false;

  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: isDarkMode ? Brightness.dark: Brightness.light,
          ),
        ),
        home: WelcomePage(),
      ),
    );
  }
}
