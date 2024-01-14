// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outwork_mx_admin_app/models/user_model.dart';
import 'package:outwork_mx_admin_app/widgets/athlete_preview_card.dart';

import '../utils/get_media_query.dart';

class AtlhetesReservedScreen extends StatefulWidget {
  const AtlhetesReservedScreen({super.key});

  @override
  State<AtlhetesReservedScreen> createState() => _AtlhetesReservedScreenState();
}

class _AtlhetesReservedScreenState extends State<AtlhetesReservedScreen> {
  late dynamic arguments;
  bool isInitialized = false;
  List<String> athleteIds = [];
  late List<UserModel> athletesData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      dynamic args = ModalRoute.of(context)!.settings.arguments;

      if (!mounted) return;

      setState(() {
        arguments = args;
        isInitialized = true;
      });

      String? classId = arguments['classId'];

      // Fetch athlete IDs
      if (classId != null) {
        fetchAthletesAssistingData(classId);
      }
    }
  }

  Future<void> fetchAthletesAssistingData(String classId) async {
    DocumentSnapshot classDoc = await FirebaseFirestore.instance
        .collection('classes')
        .doc(classId)
        .get();

    List<String> ids = List<String>.from(classDoc['athletesAssisting']);

    setState(() {
      athleteIds = ids;
    });

    // Use Future.wait to fetch all athletes' data simultaneously
    List<Future<void>> futures = [];
    for (String athleteId in athleteIds) {
      futures.add(fetchUserData(athleteId));
    }

    await Future.wait(futures);
  }

  Future<void> fetchUserData(String userId) async {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();

      UserModel athlete = UserModel(
        name: (userDoc.get('name')),
        userUID: userId,
        profilePicture: (userDoc.get('profilePicture')),
        creditsAvailable: (userDoc.get('creditsAvailable')),
        reservedClasses: (userDoc.get('reservedClasses')),
      );
      setState(() {
        athletesData.add(athlete);
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Atletas Reservados',
        ),
        toolbarHeight: TeMediaQuery.getPercentageHeight(context, 10),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TeMediaQuery.getPercentageWidth(context, 10),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 7 / 4,
          ),
          itemBuilder: (context, index) {
            return AthletePreviewCard(userModel: athletesData[index]);
          },
          itemCount: athletesData.length,
        ),
      ),
    );
  }
}
