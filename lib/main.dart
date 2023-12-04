import 'package:expense_tracker/ui/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  ColorScheme kColorScheme =
      ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 241, 21, 21));
  ColorScheme kdarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 0, 10, 27),
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kdarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kdarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        // textTheme: ThemeData().textTheme.copyWith(
        //       titleLarge: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           color: kdarkColorScheme.onSecondaryContainer,
        //           fontSize: 16),
        //     )
      ),
      theme: ThemeData().copyWith(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        // textTheme: ThemeData().textTheme.copyWith(
        //       titleLarge: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           // color: kColorScheme.onSecondaryContainer,
        //           fontSize: 16),
        //     )
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    );
  }
}
