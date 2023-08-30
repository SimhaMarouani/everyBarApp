import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iBar/screens/tabs.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 53, 47, 68),
        brightness: Brightness.dark,
        primary: const Color.fromARGB(255, 53, 47, 68),
        onPrimary: const Color.fromARGB(255, 185, 180, 199),
        secondary: const Color.fromARGB(255, 250, 240, 220),
        onSecondary: const Color.fromARGB(255, 92, 84, 112),
        background: const Color.fromARGB(255, 53, 47, 68),
      ),
      textTheme: GoogleFonts.latoTextTheme(),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const Tabs(),
    );
  }
}
