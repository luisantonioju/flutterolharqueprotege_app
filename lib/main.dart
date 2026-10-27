import 'package:flutter/material.dart';
import 'home_page.dart'; // Import relativo para evitar erro de nome de pacote

void main() {
  runApp(
    MaterialApp(
      title: 'Olhar Que Protege - Blog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 4.0,
        ),
      ),
      home: const HomePage(),
    ),
  );
}
