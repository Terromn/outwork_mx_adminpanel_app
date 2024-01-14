// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Fetch {
  final _today = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    8,
  );

  Fetch() {
    initFetcher();
  }

  dynamic _todaysClassessnapshot;

  Future<void> initFetcher() async {
    _todaysClassessnapshot = await FirebaseFirestore.instance
        .collection('classes')
        .where(
          'classTimeStamp',
          isGreaterThanOrEqualTo: _today,
          isLessThan: _today.add(const Duration(days: 1)),
        )
        .orderBy('classTimeStamp')
        .get();
  }

  Future<Map<String, List<String>>> fetchUserNamesForToday() async {
    final classIds = _todaysClassessnapshot?.docs?.map((doc) => doc.id).toList() ?? [];
    final userNamesMap = <String, List<String>>{};

    final usersSnapshot = await FirebaseFirestore.instance.collection('users').get();

    for (final userDoc in usersSnapshot.docs) {
      final reservedClasses = userDoc.data()['reservedClasses'] as List<dynamic>?;

      for (var id in reservedClasses ?? []) {
        if (classIds.contains(id)) {
          final userName = userDoc.data()['name'] as String?;
          if (userName != null) {
            userNamesMap.putIfAbsent(id, () => []);
            userNamesMap[id]!.add(userName);
          }
        }
      }
    }

    return userNamesMap;
  }

  Future<List<dynamic>> fetchClassesForToday() async {
    final classIds = _todaysClassessnapshot?.docs?.map((doc) => doc.id).toList() ?? [];
    return classIds;
  }

  Future<List<String>> fetchAthletesAssisting(String classId) async {
    final classDoc = await FirebaseFirestore.instance.collection('classes').doc(classId).get();

    final athletesAssisting = classDoc.data()?['athletesAssisting'] as List<dynamic>?;

    final athletesAssistingNames = <String>[];

    final usersSnapshot = await FirebaseFirestore.instance.collection('users').get();

    for (final userDoc in usersSnapshot.docs) {
      final userName = userDoc.data()['name'] as String?;
      if (userName != null && athletesAssisting?.contains(userDoc.id) == true) {
        athletesAssistingNames.add(userName);
      }
    }

    return athletesAssistingNames;
  }

  Future<int> fetchAtletesForTodayCount() async {
    final todayClassDocumentIds =
        _todaysClassessnapshot?.docs?.map((doc) => doc.id).toSet() ?? {};

    int count = 0;

    final usersSnapshot = await FirebaseFirestore.instance.collection('users').get();

    for (final userDoc in usersSnapshot.docs) {
      final reservedClasses = userDoc.data()['reservedClasses'] as List<dynamic>?;

      if (reservedClasses?.any((id) => todayClassDocumentIds.contains(id)) == true) {
        count++;
      }
    }

    return count;
  }

  Future<List<DateTime>> fetchFirstAndLastClassTime() async {
    final classes = _todaysClassessnapshot?.docs;

    if (classes?.isEmpty ?? true) {
      return [DateTime.now(), DateTime.now()];
    }

    final firstClassTime = classes!.first.get('classTimeStamp') as Timestamp?;
    final lastClassTime = classes!.last.get('classTimeStamp') as Timestamp?;

    final firstClassDateTime = DateTime.fromMillisecondsSinceEpoch(
            firstClassTime?.millisecondsSinceEpoch ?? 0)
        .toLocal();
    final lastClassDateTime = DateTime.fromMillisecondsSinceEpoch(
            lastClassTime?.millisecondsSinceEpoch ?? 0)
        .toLocal();

    return [firstClassDateTime, lastClassDateTime];
  }
}
