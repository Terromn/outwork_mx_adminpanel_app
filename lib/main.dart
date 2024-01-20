import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:outwork_mx_admin_app/screens/add_class_screen.dart';
import 'package:outwork_mx_admin_app/screens/qr_scanner_screen.dart';

import 'assets/app_theme.dart';
import 'firebase_options.dart';
import 'screens/athletes_reserved_screen.dart';
import 'screens/todays_classes_screen.dart';
import 'screens/drawer_menu_screen.dart';
import 'screens/verify_user_screen.dart';

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
      theme: TeAppThemeData().getDarkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => DrawerMenuScreen(),
        '/TodaysClassesScreen': (context) => const TodaysClassesScreen(),
        '/AtlhetesReservedScreen': (context) => const AtlhetesReservedScreen(),
        '/QRScannerScreen': (context) => const QRScannerScreen(),
        '/VerifyUserScreen':(context) => const VerifyUserScreen(),
        '/AddClassScreen':(context) => const AddClassScreen(),

      },
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
