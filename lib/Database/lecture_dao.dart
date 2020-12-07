import 'dart:async';
import 'package:my_rkm_hikai/Models/Lecture/lecture.dart';

import 'database.dart';

class LectureDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createLecture(Lecture lecture) async {
    final db = await dbProvider.database;
    var result = db.insert(lectureTABLE, lecture.toMap());
    return result;
  }

  //Get All Lecture items
  //Searches if query string was passed
  Future<List<Lecture>> getLecture({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(lectureTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(lectureTABLE, columns: columns);
    }

    List<Lecture> lectures = result.isNotEmpty
        ? result.map((item) => Lecture.fromMap(item)).toList()
        : [];
    return lectures;
  }

  //Update Todo record
  Future<int> updateLecture(Lecture lecture) async {
    final db = await dbProvider.database;

    var result = await db.update(lectureTABLE, lecture.toMap(),
        where: "lectureId = ?", whereArgs: [lecture.lectureId]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteLecture(String lectureId) async {
    final db = await dbProvider.database;
    var result = await db
        .delete(lectureTABLE, where: 'lectureId = ?', whereArgs: [lectureId]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllLectures() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      lectureTABLE,
    );

    return result;
  }
}
