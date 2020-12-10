import 'dart:async';

import 'package:my_rkm_hikai/Models/Chapter/chapter.dart';


import 'database.dart';

class ChapterDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createChapter(Chapter chapter) async {
    final db = await dbProvider.database;
    var result = db.insert(tblview, chapter.toMap());
    return result;
  }

  //Get All Chapter items
  //Searches if query string was passed
  Future<List<Chapter>> getChapter({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(tblview,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(tblview, columns: columns);
    }

    List<Chapter> chapters = result.isNotEmpty
        ? result.map((item) => Chapter.fromMap(item)).toList()
        : [];
    return chapters;
  }

  //Update Todo record
  Future<int> updateChapter(Chapter chapter) async {
    final db = await dbProvider.database;

    var result = await db.update(tblview, chapter.toMap(),
        where: "chapterNo = ?", whereArgs: [chapter.chapterNo]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteChapter(String chapterNo) async {
    final db = await dbProvider.database;
    var result = await db
        .delete(tblview, where: 'chapterNo = ?', whereArgs: [chapterNo]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllChapters() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      tblview,
    );

    return result;
  }
}
