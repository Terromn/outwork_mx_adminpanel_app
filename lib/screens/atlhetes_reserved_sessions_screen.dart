// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:outwork_mx_admin_app/utils/get_media_query.dart';
import 'package:outwork_mx_admin_app/widgets/today_class_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodaysClassesScreen extends StatelessWidget {
  const TodaysClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as dynamic;
    // final userCount = data?[0] as int;
    final classIds = data?[1] as List<String>;
    // final userNames = data?[3] as Map<String, List<String>>;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clases De Hoy',
        ),
        toolbarHeight: TeMediaQuery.getPercentageHeight(context, 10),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TeMediaQuery.getPercentageWidth(context, 15),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 7 / 4,
          ),
          itemCount: classIds.length,
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('classes')
                  .doc(classIds[index])
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return TodayClassCard(
                    classDuration: null,
                    data: null,
                    screen: null,
                    coachName: "Loading...",
                    atletasAsistiendo: 0,
                    classType: "Loading...",
                    classTime: null,
                  );
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.hasData) {
                  final classData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final classCoach = classData['classCoach'];
                  // ignore: unused_local_variable
                  final classDescription = classData['classDescription'];
                  final classDuration = classData['classDuration'];
                  final classLimitSpaces = classData['classLimitSpaces'];
                  final classTimeStamp = classData['classTimeStamp'];
                  final classType = classData['classType'];

                  return TodayClassCard(
                    classDuration: classDuration,
                    data: data,
                    screen: "/AtlhetesReservedClassesScreen",
                    coachName: classCoach,
                    atletasAsistiendo: classLimitSpaces,
                    classType: classType,
                    classTime: classTimeStamp.toDate(),
                  );
                }

                return Text('No data available.');
              },
            );
          },
        ),
      ),
    );
  }
}
