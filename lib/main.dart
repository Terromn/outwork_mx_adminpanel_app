import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'assets/app_theme.dart';
import 'firebase_options.dart';
import 'screens/drawer_menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: TeAppThemeData().getDarkTheme(context),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerMenuScreen();
  }
}
