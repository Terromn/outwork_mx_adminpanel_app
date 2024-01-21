// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';
import 'package:outwork_mx_admin_app/assets/app_theme.dart';

import '../utils/get_media_query.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({super.key});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  Duration classDuration = const Duration(minutes: 60);
  String classCoach = 'Adrian';
  String classType = 'Calistenia';
  int classCost = 1;
  int classLimitSpaces = 12;
  Timestamp classStartTimestamp = Timestamp.fromDate(DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 0));

  List<String> classCoachesDropDownMenu = [
    'Adrian',
    'Maricé',
    'Andres',
    'Delisa',
  ];

  List<String> classTypeDropDownMenu = [
    'Yoga',
    'Calistenia',
    'KB Power',
    'HIIT',
  ];

  Map<String, String> classTypeDescriptions = {
    'Calistenia': 'La clase de calistenia consiste en un entrenamiento con el propio peso del cuerpo al aire libre. Se trabaja con un enfoque en fuerza, resistencia, equilibrio y coordinación, complementado con pesos libres, y pesas rusas.',
    'Yoga': 'La clase de yoga consiste en una practica diseñada para equilibrar el cuerpo, la mente y la respiración. La practica se enfoca en meditación para obtener el control propio, ejercer la flexibilidad y la fuerza.',
    'KB Power': 'No han Pasado la Descricion de KB Power',
    'HIIT': 'La clase de calistenia consiste en un entrenamiento con el propio peso del cuerpo al aire libre. Se trabaja con un enfoque en fuerza, resistencia, equilibrio y coordinación, complementado con pesos libres, y pesas rusas.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
          child: const Icon(
            color: Colors.black,
            Icons.done,
            size: 52,
          ),
          onPressed: () {
            showConfirmationDialog();
          }),
      appBar: AppBar(
        title: const Text(
          'Agregar Clase',
        ),
        toolbarHeight: TeMediaQuery.getPercentageHeight(context, 10),
      ),
      body: Center(
        child: SizedBox(
          width: TeMediaQuery.getPercentageWidth(context, 80),
          child: Column(
            children: [
              teDropDownMenu(context, classCoach, classCoachesDropDownMenu,
                  (newValue) {
                setState(() {
                  classCoach = newValue;
                });
              }),
              teDropDownMenu(context, classType, classTypeDropDownMenu,
                  (newValue) {
                setState(() {
                  classType = newValue;
                });
              }),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: teCounter(context, 'Costo', classCost, (newValue) {
                      setState(() {
                        classCost = newValue;
                      });
                    }),
                  ),
                  const SizedBox(
                    width: TeAppThemeData.contentMargin,
                  ),
                  Expanded(
                    flex: 1,
                    child: teCounter(context, 'Cupo', classLimitSpaces,
                        (newValue) {
                      setState(() {
                        classLimitSpaces = newValue;
                      });
                    }),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: teDurationCounter(context, 'Duración', classDuration,
                        (newValue) {
                      setState(() {
                        classDuration = newValue;
                      });
                    }),
                  ),
                  const SizedBox(
                    width: TeAppThemeData.contentMargin,
                  ),
                  Expanded(
                    flex: 1,
                    child: teSelectTimeStamp(context, classStartTimestamp,
                        (newValue) {
                      setState(() {
                        classStartTimestamp = newValue;
                      });
                    }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirma La Creacion De Esta Clase'),
          content: const Text('¿Seguro De Que Quieres Crear Esta Clase?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',  style: TextStyle(color: TeAppColorPalette.white),),
            ),
            TextButton(
              onPressed: () {
                saveClassToFirebase();
                Navigator.of(context).pop();
              },
              child: const Text('OK',  style: TextStyle(color: TeAppColorPalette.white),),
            ),
          ],
        );
      },
    );
  }

  void saveClassToFirebase() async {
    try {
      // Reference to the "classes" collection
      CollectionReference classesCollection =
          FirebaseFirestore.instance.collection('classes');

      // Generate a recommended ID from Firebase
      DocumentReference newClassRef = classesCollection.doc();
      String classDescription = classTypeDescriptions[classType] ?? '';
      // Add the class details to the new document
      await newClassRef.set({
        'classCoach': classCoach,
        'classCost': classCost,
        'classDescription': classDescription,
        'classDuration': classDuration.inMinutes,
        'classLimitSpaces': classLimitSpaces,
        'classTimeStamp': classStartTimestamp,
        'classType': classType,
        'athletesAssisting': [], // Empty list for now, to be filled later
      });

      // Navigate back to the home page
      Navigator.popUntil(context, (route) => route.isFirst);

      // Show another dialog in the home page
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Clase Creada'),
            content: const Text('La clase se ha creado exitosamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar',  style: TextStyle(color: TeAppColorPalette.white),),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle errors, log them, or show a message to the user
      print('Error creating class: $e');
    }
  }

  teSelectTimeStamp(
      BuildContext context, Timestamp timestamp, Function onChanged) {
    return GestureDetector(
      onTap: () {
        _selectDate(context, timestamp, onChanged);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: TeAppColorPalette.green,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          width: double.infinity,
          margin: EdgeInsets.only(
              top: TeMediaQuery.getPercentageHeight(context, 5)),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Center(
              child: Text(
                formattedDateTime(timestamp.toDate()),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Existing code for teDropDownMenu, teCounter, and teDurationCounter

  Future<void> _selectDate(
    BuildContext context,
    Timestamp timestamp,
    Function onChanged,
  ) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: timestamp.toDate(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      // ignore: use_build_context_synchronously
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(timestamp.toDate()),
      );

      if (pickedTime != null) {
        DateTime newDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        onChanged(Timestamp.fromDate(newDateTime));
      }
    }
  }

  String formattedDateTime(DateTime dateTime) {
    return DateFormat('MMMM, d - h:mma').format(dateTime);
  }
}

Container teDropDownMenu(
    BuildContext context, dynamic value, List items, Function onChanged) {
  return Container(
    padding: const EdgeInsets.only(top: 4),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: TeAppColorPalette.green,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      width: double.infinity,
      margin:
          EdgeInsets.only(top: TeMediaQuery.getPercentageHeight(context, 5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            iconSize: 0,
            value: value,
            isExpanded: true,
            onChanged: (newValue) {
              onChanged(newValue);
            },
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Center(
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ),
  );
}

teCounter(BuildContext context, String title, int value, Function onChanged) {
  return Container(
    padding: const EdgeInsets.only(top: 4),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: TeAppColorPalette.green,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      width: double.infinity,
      margin:
          EdgeInsets.only(top: TeMediaQuery.getPercentageHeight(context, 5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      onChanged(value - 1);
                    },
                  ),
                  Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      onChanged(value + 1);
                    },
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

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitHours = twoDigits(duration.inHours);

  return '$twoDigitHours:$twoDigitMinutes';
}

teDurationCounter(
    BuildContext context, String title, Duration value, Function onChanged) {
  return Container(
    padding: const EdgeInsets.only(top: 4),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: TeAppColorPalette.green,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      width: double.infinity,
      margin:
          EdgeInsets.only(top: TeMediaQuery.getPercentageHeight(context, 5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      Duration newValue = value - const Duration(minutes: 30);
                      onChanged(newValue.isNegative ? Duration.zero : newValue);
                    },
                  ),
                  Text(
                    formatDuration(value),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      onChanged(value + const Duration(minutes: 30));
                    },
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
