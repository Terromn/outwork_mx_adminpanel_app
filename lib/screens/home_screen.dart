// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';
import 'package:outwork_mx_admin_app/assets/app_theme.dart';
import 'package:outwork_mx_admin_app/utils/get_media_query.dart';

const double _cardsPadding = 22;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: TeAppColorPalette.blackLight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: TeAppColorPalette.green,
            width: double.infinity,
            height: TeMediaQuery.getPercentageHeight(context, 20),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: TeAppThemeData.contentMargin * 1.25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bienvenido,",
                      style: Theme.of(context).textTheme.titleMedium),
                  Text("Administrador",
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
          ),
          SizedBox(
            height: TeMediaQuery.getPercentageHeight(context, 80),
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: TeAppThemeData.contentMargin * .75,
                    vertical: TeAppThemeData.contentMargin * .75),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _RightWidget(
                            child: _InformationSmallCard(
                                icon: FontAwesomeIcons.peopleGroup,
                                title: "79 Atletas",
                                subtitle: "Reservaron"),
                          ),
                          const SizedBox(
                              height: TeAppThemeData.contentMargin * .5),
                          _RightWidget(
                            child: _InformationSmallCard(
                                icon: FontAwesomeIcons.solidClock,
                                title: "6:00 AM",
                                subtitle: "Primera Clase"),
                          ),
                          const SizedBox(
                              height: TeAppThemeData.contentMargin * .5),
                          _RightWidget(
                            child: _InformationSmallCard(
                                icon: FontAwesomeIcons.bed,
                                title: "8:00 PM",
                                subtitle: "Ultima Clase"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: TeAppThemeData.contentMargin * .75),
                    const Expanded(
                      flex: 3,
                      child: _LeftWidget(),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class _InformationSmallCard extends StatelessWidget {
  IconData icon;
  String title;
  String subtitle;

  _InformationSmallCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(
                left: _cardsPadding, right: _cardsPadding * 2),
            child: Container(
              height: 68,
              width: 68,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: TeAppColorPalette.green),
              child: Icon(
                icon,
                size: 32,
                color: TeAppColorPalette.black,
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.displayLarge),
            Text(subtitle, style: Theme.of(context).textTheme.displayMedium),
          ],
        )
      ],
    );
  }
}

class _LeftWidget extends StatelessWidget {
  const _LeftWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: TeAppColorPalette.black,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: _cardsPadding),
                    child: Container(
                      height: 68,
                      width: 68,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: TeAppColorPalette.green),
                      child: const Icon(
                        FontAwesomeIcons.dumbbell,
                        size: 32,
                        color: TeAppColorPalette.black,
                      ),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Coaches",
                        style: Theme.of(context).textTheme.displayLarge),
                    Text("De Hoy",
                        style: Theme.of(context).textTheme.displayMedium),
                  ],
                )
              ],
            ),
            Expanded(
              child: SizedBox(
                child: Container(),
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: _cardsPadding ),
                    child: Container(
                      height: 68,
                      width: 68,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: TeAppColorPalette.green),
                      child: const Icon(
                        Icons.sports_gymnastics_rounded,
                        size: 56,
                        color: TeAppColorPalette.black,
                      ),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Clases",
                        style: Theme.of(context).textTheme.displayLarge),
                    Text("De Hoy",
                        style: Theme.of(context).textTheme.displayMedium),
                  ],
                )
              ],
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RightWidget extends StatelessWidget {
  Widget child;

  _RightWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: TeAppColorPalette.black,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(_cardsPadding),
          child: child,
        ),
      ),
    );
  }
}
