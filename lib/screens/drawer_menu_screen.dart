import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:outwork_mx_admin_app/screens/administration_screen.dart';
import 'package:outwork_mx_admin_app/screens/analytics_screen.dart';
import 'package:outwork_mx_admin_app/widgets/menu_button.dart';

import '../assets/app_color_palette.dart';
import '../assets/app_theme.dart';
import '../utils/get_media_query.dart';
import '../widgets/te_floating_action_button.dart';
import 'home_screen.dart';

// ignore: must_be_immutable
class DrawerMenuScreen extends StatefulWidget {
  Widget _currentRightScreen = const HomeScreen();

  DrawerMenuScreen({super.key});

  @override
  State<DrawerMenuScreen> createState() => _DrawerMenuScreenState();
}

class _DrawerMenuScreenState extends State<DrawerMenuScreen> {
  get _currentRightScreen => widget._currentRightScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: const TeFloatingActionButton(),
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
                    padding: const EdgeInsets.only(
                        top: TeAppThemeData.contentMargin * 2),
                    child: Image.asset(
                      'assets/outworkLogo.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Text(
                    "OUTWORK",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: TeAppThemeData.contentMargin,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TeAppThemeData.contentMargin * 2),
                    child: Column(
                      children: [
                        TeMenuButton(
                            textContent: 'Home',
                            buttonIcon: FontAwesomeIcons.house,
                            onPressed: () {
                              // ignore: avoid_print
                              print("home button pressed");
                              setState(() {
                                widget._currentRightScreen = const HomeScreen();
                              });
                            }),
                        TeMenuButton(
                            textContent: 'Analytics',
                            buttonIcon: FontAwesomeIcons.chartLine,
                            onPressed: () {
                              // ignore: avoid_print
                              print("analytics button pressed");
                              setState(() {
                                widget._currentRightScreen =
                                    const AnalyticsScreen();
                              });
                            }),
                        TeMenuButton(
                            textContent: 'Admin',
                            buttonIcon: FontAwesomeIcons.unlockKeyhole,
                            onPressed: () {
                              // ignore: avoid_print
                              print("admin button pressed");
                              setState(() {
                                widget._currentRightScreen =
                                    const AdministrationScreen();
                              });
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: TeAppColorPalette.blackLight,
              ),
              width: TeMediaQuery.getPercentageWidth(context, 70),
              child: _currentRightScreen,
            )
          ],
        ));
  }
}


