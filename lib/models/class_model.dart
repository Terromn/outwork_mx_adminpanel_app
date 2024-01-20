import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel {
  dynamic athletesAssiting;
  String? classCoach;
  int? classCost;
  String? classDescription;
  int? classDuration;
  int? classLimitSpaces;
  Timestamp? classTimeStamp;
  String? classType;

  ClassModel({
   this.athletesAssiting,
   this.classCoach,
   this.classCost,
   this.classDescription,
   this.classDuration,
   this.classLimitSpaces,
   this.classTimeStamp,
   this.classType,
  });
}