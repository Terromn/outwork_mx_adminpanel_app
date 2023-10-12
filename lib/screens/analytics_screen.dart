import 'package:flutter/material.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: double.infinity,
      width: double.infinity,
      color: TeAppColorPalette.blackLight,
      child: const Center(child: Text("Analytics under construction...")),
    );
  }
}