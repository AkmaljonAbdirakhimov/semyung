import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:semyung/providers/authentication_provider.dart';
import 'package:semyung/screens/home_screen.dart';

import 'providers/bookins_provider.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  BookingsProvider.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = AuthenticationProvider();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: authenticationProvider.checkUser(),
          builder: (context, snapshot) {
            return snapshot.data == null
                ? const LoginScreen()
                : const HomeScreen();
          }),
    );
  }
}
