import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iBar/screens/tabs.dart';

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
      textTheme: GoogleFonts.latoTextTheme(),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const Tabs(),
    );
  }
}
