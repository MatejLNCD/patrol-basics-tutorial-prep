import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:patrol_tutorial_prep/pages/sign_in_page.dart';
import 'package:patrol_tutorial_prep/ui/style/colors.dart';

void main() {
  initApp();
  runApp(const MainApp());
}

void initApp() {
  tz.initializeTimeZones();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow),
        primaryColor: PTColors.lcBlack,
        appBarTheme: const AppBarTheme(
          backgroundColor: PTColors.lcBlack,
          foregroundColor: PTColors.textWhite,
        ),
        canvasColor: PTColors.textDark,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: PTColors.lcYellow.withOpacity(0.5),
          cursorColor: PTColors.textWhite,
          selectionHandleColor: PTColors.lcYellow,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: PTColors.lcWhite,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: PTColors.error,
            ),
          ),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: PTColors.textWhite,
          ),
          floatingLabelStyle: TextStyle(
            color: PTColors.lcYellow,
          ),
          errorStyle: TextStyle(
            color: PTColors.error,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: PTColors.lcYellow,
            foregroundColor: PTColors.textDark,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}
