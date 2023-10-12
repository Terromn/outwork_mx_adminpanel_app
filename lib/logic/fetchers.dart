// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Fetch {
  final _today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Fetch() {
    initFetcher();
  }

  late QuerySnapshot _todaysClassessnapshot;

  Future<void> initFetcher() async {
    _todaysClassessnapshot = await FirebaseFirestore.instance
        .collection('classes')
        .where(
          'classTimeStamp',
          isGreaterThanOrEqualTo: _today.toUtc(),
          isLessThan: _today.add(const Duration(days: 1)).toUtc(),
        )
        .orderBy('classTimeStamp')
        .get();
  }

Future<Map<String, List<String>>> fetchUserNamesForToday() async {
  final classIds = _todaysClassessnapshot.docs.map((doc) => doc.id).toList();
  final userNamesMap = <String, List<String>>{};

  final usersSnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  for (final userDoc in usersSnapshot.docs) {
    final reservedClasses =
        userDoc.data()['reservedClasses'] as List<dynamic>;

    for (var id in reservedClasses) {
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
    final classIds = _todaysClassessnapshot.docs.map((doc) => doc.id).toList();
    return classIds;
  }

  Future<int> fetchAtletesForTodayCount() async {
    final todayClassDocumentIds =
        _todaysClassessnapshot.docs.map((doc) => doc.id).toSet();

    int count = 0;

    final usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (final userDoc in usersSnapshot.docs) {
      final reservedClasses =
          userDoc.data()['reservedClasses'] as List<dynamic>;

      if (reservedClasses.any((id) => todayClassDocumentIds.contains(id))) {
        count++;
      }
    }

    return count;
  }

  Future<List<DateTime>> fetchFirstAndLastClassTime() async {
    final classes = _todaysClassessnapshot.docs;

    if (classes.isEmpty) {
      return [DateTime.now(), DateTime.now()];
    }

    final firstClassTime = classes.first.get('classTimeStamp') as Timestamp;
    final lastClassTime = classes.last.get('classTimeStamp') as Timestamp;

    final firstClassDateTime = DateTime.fromMillisecondsSinceEpoch(
            firstClassTime.millisecondsSinceEpoch)
        .toLocal();
    final lastClassDateTime = DateTime.fromMillisecondsSinceEpoch(
            lastClassTime.millisecondsSinceEpoch)
        .toLocal();

    return [firstClassDateTime, lastClassDateTime];
  }
}
