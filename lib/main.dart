import 'package:flutter/material.dart';
import 'package:semyung/screens/home_screen.dart';

import 'providers/bookins_provider.dart';

void main() {
  BookingsProvider.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
