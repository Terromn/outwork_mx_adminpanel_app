import 'package:flutter/material.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';
import 'package:outwork_mx_admin_app/assets/app_theme.dart';
import 'package:outwork_mx_admin_app/utils/get_media_query.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: TeAppThemeData().getDarkTheme(context),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: TeAppColorPalette.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(-4, 0),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          width: TeMediaQuery.getPercentageWidth(context, 30),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: TeAppThemeData.contentMargin),
              child: Image.asset(
              'assets/outworkLogo.png', 
              width: 200, 
              height: 200, 
                      ),
            ),

          ]),
        ),
        Container(
          decoration: const BoxDecoration(
            color: TeAppColorPalette.blackLight,
          ),
          width: TeMediaQuery.getPercentageWidth(context, 70),
        )
      ],
    ));
  }
}
