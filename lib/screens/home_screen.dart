import 'package:flutter/material.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: double.infinity,
      color: TeAppColorPalette.blackLight,
    );
  }
}