// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';
import 'package:outwork_mx_admin_app/assets/app_theme.dart';
import 'package:outwork_mx_admin_app/utils/get_icon_based_on_session.dart';

class TodayClassCard extends StatelessWidget {
  String coachName;
  String classType;
  DateTime? classTime;
  int? classDuration;
  int? atletasAsistiendo;
  String? screen;
  dynamic data;

  String? classId;

  TodayClassCard({
    required this.classDuration,
    required this.data,
    required this.screen,
    required this.atletasAsistiendo,
    required this.coachName,
    required this.classType,
    required this.classTime,
    this.classId,
    super.key,
  });


     @override
  Widget build(BuildContext context) {
    classDuration ??= 0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          screen!,
          arguments: {
            'data': data,
            'classId': classId,
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
        child: Container(
          decoration: BoxDecoration(
            color: TeAppColorPalette.black,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: TeAppColorPalette.black,
                offset: Offset(0, 0),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: TeAppColorPalette.green,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: GetIconBasedOnSession.getIcon(
                      classType,
                      36,
                      TeAppColorPalette.black,
                    ),
                  ),
                ),
              ),
              Expanded( // Moved the Expanded widget inside the Row
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$classType ${classTime != null ? DateFormat.jm().format(classTime!) : ""}",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$atletasAsistiendo Atletas asistiendo",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$coachName, $classDuration ${classDuration! <= 1 ? "hora" : "horas"}",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            ],
          ), 
        ),
      ),
    );
  }
  }
