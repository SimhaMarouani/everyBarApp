import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iBar/screens/tabs.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
        useMaterial3: true,
        primaryColor: const Color.fromARGB(255, 121, 21, 91),
        secondaryHeaderColor: const Color.fromARGB(255, 194, 51, 115),
        highlightColor: const Color.fromARGB(255, 246, 99, 92),
        hintColor: const Color.fromARGB(255, 255, 186, 134),
        primaryTextTheme: GoogleFonts.dancingScriptTextTheme(),
        textTheme: GoogleFonts.latoTextTheme());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const Tabs(),
    );
  }
}
