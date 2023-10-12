// ignore_for_file: must_be_immutable, library_private_types_in_public_api, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';
import 'package:outwork_mx_admin_app/assets/app_theme.dart';
import 'package:outwork_mx_admin_app/logic/fetchers.dart';
import 'package:outwork_mx_admin_app/utils/get_media_query.dart';
import 'package:intl/intl.dart';

const double _cardsPadding = 22;
final Fetch _fetch = Fetch();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
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
                left: TeAppThemeData.contentMargin * 1.25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bienvenido,",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "Administrador",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
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
                vertical: TeAppThemeData.contentMargin * .75,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: FutureBuilder<List<dynamic>>(
                      future: Future.wait([
                        _fetch.fetchAtletesForTodayCount(),
                        _fetch.fetchClassesForToday(),
                        _fetch.fetchFirstAndLastClassTime(),
                        _fetch.fetchUserNamesForToday(),
                      ]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            children: [
                              _LeftWidget(
                                child: _InformationSmallCard(
                                  data: null,
                                  screen: null,
                                  icon: FontAwesomeIcons.peopleGroup,
                                  title: "Usuarios",
                                  subtitle: "Reservaron",
                                ),
                              ),
                              const SizedBox(
                                  height: TeAppThemeData.contentMargin * 0.5),
                              _LeftWidget(
                                child: _InformationSmallCard(
                                  screen: null,
                                  data: null,
                                  icon: FontAwesomeIcons.solidClock,
                                  title: "AM/PM",
                                  subtitle: "Primera Clase",
                                ),
                              ),
                              const SizedBox(
                                  height: TeAppThemeData.contentMargin * 0.5),
                              _LeftWidget(
                                child: _InformationSmallCard(
                                  screen: null,
                                  data: null,
                                  icon: FontAwesomeIcons.bed,
                                  title: "AM/PM",
                                  subtitle: "Ultima Clase",
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          final data = snapshot.data;
                          final userCount = data?[0] as int;
                          final classIds = data?[1] as List<String>;
                          final firstAndLastClassTime =
                              data?[2] as List<DateTime>;

                          final firstClassTime = firstAndLastClassTime[0];
                          final lastClassTime = firstAndLastClassTime[1];

                          final timeFormat = DateFormat.jm();

                          return Column(
                            children: [
                              _LeftWidget(
                                child: _InformationSmallCard(
                                  data: data,
                                  screen: "/TodaysClassesScreen",
                                  icon: FontAwesomeIcons.peopleGroup,
                                  title: "$userCount Usuarios",
                                  subtitle: "Reservaron",
                                ),
                              ),
                              const SizedBox(
                                  height: TeAppThemeData.contentMargin * 0.5),
                              _LeftWidget(
                                child: _InformationSmallCard(
                                  screen: null,
                                  data: null,
                                  icon: FontAwesomeIcons.solidClock,
                                  title: timeFormat.format(firstClassTime),
                                  subtitle: "Primera Clase",
                                ),
                              ),
                              const SizedBox(
                                  height: TeAppThemeData.contentMargin * 0.5),
                              _LeftWidget(
                                child: _InformationSmallCard(
                                  screen: null,
                                  data: null,
                                  icon: FontAwesomeIcons.bed,
                                  title: timeFormat.format(lastClassTime),
                                  subtitle: "Ultima Clase",
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: TeAppThemeData.contentMargin * .75),
                  const Expanded(
                    flex: 3,
                    child: _RightWidget(),
                  ),
                ],
              ),
            ),
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
  String? screen;
  dynamic data;

  _InformationSmallCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.screen,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (screen == null) return;
        Navigator.pushNamed(context, screen!, arguments: data);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: _cardsPadding,
              right: _cardsPadding * 2,
            ),
            child: Container(
              height: 68,
              width: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: TeAppColorPalette.green,
              ),
              child: Icon(
                icon,
                size: 32,
                color: TeAppColorPalette.black,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.displayLarge),
              Text(subtitle, style: Theme.of(context).textTheme.displayMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class _RightWidget extends StatelessWidget {
  const _RightWidget();

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: _cardsPadding),
                  child: Container(
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: TeAppColorPalette.green,
                    ),
                    child: const Icon(
                      FontAwesomeIcons.dumbbell,
                      size: 32,
                      color: TeAppColorPalette.black,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Coaches",
                        style: Theme.of(context).textTheme.displayLarge),
                    Text("De Hoy",
                        style: Theme.of(context).textTheme.displayMedium),
                  ],
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                // Fetch data from Firestore "classes" collection and filter for today
                future: FirebaseFirestore.instance
                    .collection('classes')
                    .where(
                      'classTimeStamp',
                      isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day)
                          .toUtc(),
                      isLessThan: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day + 1)
                          .toUtc(),
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final classes = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: classes.length,
                      itemBuilder: (context, index) {
                        final classCoach =
                            classes[index].get('classCoach') ?? 'Unknown';
                        final classType =
                            classes[index].get('classType') ?? 'Unknown';

                        return ListTile(
                          title: Text(
                            classCoach,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          subtitle: Text(
                            classType,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: _cardsPadding),
                  child: Container(
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: TeAppColorPalette.green,
                    ),
                    child: const Icon(
                      Icons.sports_gymnastics_rounded,
                      size: 56,
                      color: TeAppColorPalette.black,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Clases",
                        style: Theme.of(context).textTheme.displayLarge),
                    Text("De Hoy",
                        style: Theme.of(context).textTheme.displayMedium),
                  ],
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                // Fetch data from Firestore "classes" collection and filter for today
                future: FirebaseFirestore.instance
                    .collection('classes')
                    .where(
                      'classTimeStamp',
                      isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day)
                          .toUtc(),
                      isLessThan: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day + 1)
                          .toUtc(),
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final classes = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: classes.length,
                      itemBuilder: (context, index) {
                        final classType =
                            classes[index].get('classType') ?? 'Unknown';
                        final classTimeStamp =
                            classes[index].get('classTimeStamp') as Timestamp;
                        final classTime = DateTime.fromMillisecondsSinceEpoch(
                                classTimeStamp.millisecondsSinceEpoch)
                            .toLocal();

                        return ListTile(
                          title: Text(
                            classType,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          subtitle: Text(
                            DateFormat.jm().format(classTime),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeftWidget extends StatelessWidget {
  Widget child;

  _LeftWidget({required this.child});

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
