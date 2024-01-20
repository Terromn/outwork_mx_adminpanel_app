import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outwork_mx_admin_app/assets/app_color_palette.dart';
import '../models/class_model.dart'; // Import the ClassModel

class ClassPreviewSlimWidget extends StatelessWidget {
  final ClassModel
      classModel; // Add this line to accept ClassModel as a parameter

  const ClassPreviewSlimWidget({required this.classModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22.0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: TeAppColorPalette.blackLight,
        ),
        child: Center(
          child: Text(
            "Clase de ${classModel.classType}, a las ${formatTime(classModel.classTimeStamp)} con ${classModel.classCoach}",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }

  String formatTime(Timestamp? timestamp) {
    DateTime? dateTime = timestamp?.toDate();
    int? hour = dateTime?.hour;
    String period = 'AM';

    if (hour! >= 12) {
      period = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
    }

    return '$hour:${dateTime?.minute.toString().padLeft(2, '0')} $period';
  }
}
