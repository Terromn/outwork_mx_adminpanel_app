// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/class_model.dart';
import '../models/user_model.dart';
import '../widgets/class_preview_slim.dart';
import '../assets/app_color_palette.dart';
import '../assets/app_theme.dart';
import '../utils/get_media_query.dart';

class VerifyUserScreen extends StatefulWidget {
  const VerifyUserScreen({super.key});

  @override
  _VerifyUserScreenState createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  late dynamic arguments;
  bool isInitialized = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isValidCode = false;

  UserModel athlete = UserModel(
    creditsAvailable: 0,
    name: '',
    userUID: '',
    profilePicture: '',
    reservedClasses: [],
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      arguments = ModalRoute.of(context)!.settings.arguments;
      validateCode(arguments['userUID']);
      isInitialized = true;
    }
  }

  void validateCode(String userUID) {
    String userUIDFromQR = userUID;

    firestore
        .collection('users')
        .doc(userUIDFromQR)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        fetchUserData(userUIDFromQR);
        setState(() {
          isValidCode = true;
        });
      } else {
        setState(() {
          isValidCode = false;
        });
      }
    });
  }

  Future<List<ClassModel>> fetchReservedClassesForToday(
      List<dynamic> reservedClassIds) async {
    List<ClassModel> reservedClasses = [];

    for (String classId in reservedClassIds) {
      DocumentSnapshot classDoc = await FirebaseFirestore.instance
          .collection('classes')
          .doc(classId)
          .get();

      Timestamp classTimeStamp = classDoc.get('classTimeStamp');

      if (isToday(classTimeStamp.toDate())) {
        ClassModel classModel = ClassModel(
          athletesAssiting: (classDoc.get('athletesAssisting')),
          classCoach: (classDoc.get('classCoach')),
          classCost: (classDoc.get('classCost')),
          classDescription: (classDoc.get('classDescription')),
          classDuration: (classDoc.get('classDuration')),
          classLimitSpaces: (classDoc.get('classLimitSpaces')),
          classTimeStamp: classTimeStamp,
          classType: (classDoc.get('classType')),
        );

        reservedClasses.add(classModel);
      }
    }

    return reservedClasses;
  }

  bool isToday(DateTime dateTime) {
    DateTime now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  Future<void> fetchUserData(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    setState(() {
      athlete = UserModel(
        name: (userDoc.get('name')),
        userUID: userId,
        profilePicture: (userDoc.get('profilePicture')),
        creditsAvailable: (userDoc.get('creditsAvailable')),
        reservedClasses: (userDoc.get('reservedClasses')),
      );
    });
  }

  Future<void> updateCreditsAndClose() async {
    // Update creditsAvailable in the user's document
    await FirebaseFirestore.instance.collection('users').doc(athlete.userUID).update({
      'creditsAvailable': athlete.creditsAvailable,
    });

    // Close the screen
    Navigator.pushNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil de ${athlete.name}',
        ),
        toolbarHeight: TeMediaQuery.getPercentageHeight(context, 10),
        leading: Container(), // Remove the back button
        actions: [
          IconButton(
            icon: const Icon(Icons.save, size: 36),
            onPressed: () {
              // Show a dialog to confirm and update creditsAvailable
              showDialog(
                
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    surfaceTintColor: TeAppColorPalette.black,
                    backgroundColor: TeAppColorPalette.black,
                    title: const Text('Guardar Cambios'),
                    content: const Text('¿Estás seguro de guardar los cambios?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Cancelar', style: TextStyle(color: TeAppColorPalette.white),),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Update creditsAvailable and close the screen
                          await updateCreditsAndClose();
                        },
                        child: const Text('Guardar', style: TextStyle(color: TeAppColorPalette.white),),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(TeAppThemeData.contentMargin),
            child: Container(
              decoration: BoxDecoration(
                color: TeAppColorPalette.black,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(TeAppThemeData.contentMargin),
                    child: Column(children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: TeAppColorPalette.green,
                        backgroundImage: AssetImage(
                            'assets/defaultProfilePictures/${athlete.profilePicture}'),
                      ),
                      const SizedBox(height: TeAppThemeData.contentMargin),
                      Text(athlete.name,
                          style: Theme.of(context).textTheme.displayLarge),
                      const SizedBox(height: TeAppThemeData.contentMargin),
                      Text(
                        '${athlete.creditsAvailable} Créditos disponibles',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(TeAppThemeData.contentMargin),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: TeAppColorPalette.black,
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: TeAppColorPalette.green,
                          ),
                          child: const Icon(
                            size: 36,
                            Icons.calendar_today,
                            color: TeAppColorPalette.black,
                          ),
                        ),
                        const SizedBox(
                          width: TeAppThemeData.contentMargin * .5,
                        ),
                        Text(
                          'Clases Reservadas Para Hoy',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<ClassModel>>(
                        future: fetchReservedClassesForToday(
                            athlete.reservedClasses),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No Hay Clases Reservadas'));
                          } else {
                            List<ClassModel> reservedClasses = snapshot.data!;
                            return ListView.builder(
                              itemCount: reservedClasses.length,
                              itemBuilder: (BuildContext context, int index) {
                                ClassModel classModel =
                                    reservedClasses[index];
                                return ClassPreviewSlimWidget(
                                    classModel: classModel);
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Column(
                      children: [
                        Row(children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: TeAppColorPalette.green,
                            ),
                            child: const Icon(
                              size: 36,
                              Icons.monetization_on,
                              color: TeAppColorPalette.black,
                            ),
                          ),
                          const SizedBox(
                            width: TeAppThemeData.contentMargin * .5,
                          ),
                          Text(
                            'Agregar O Remover Creditos',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ]),
                        const SizedBox(
                          height: TeAppThemeData.contentMargin * .2,
                        ),
                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: TeAppColorPalette.black,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  size: 40,
                                ),
                                color: TeAppColorPalette.white,
                                onPressed: () {
                                  if (athlete.creditsAvailable > 0) {
                                    setState(() {
                                      athlete.creditsAvailable--;
                                    });
                                  }
                                },
                              ),
                              Text(
                                athlete.creditsAvailable.toString(),
                                style:
                                    Theme.of(context).textTheme.displayLarge,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  size: 40,
                                ),
                                color: TeAppColorPalette.white,
                                onPressed: () {
                                  setState(() {
                                    athlete.creditsAvailable++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
