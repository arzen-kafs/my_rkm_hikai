import 'dart:async';

import 'package:my_rkm_hikai/Models/Chapter/chapter.dart';
import 'package:my_rkm_hikai/Models/Views/Views.dart';


import 'database.dart';

class MyviewDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createMyview(Views views) async {
    final db = await dbProvider.database;
    var result = db.insert(tblview, views.toMap());
    return result;
  }

  //Get All Chapter items
  //Searches if query string was passed


  //Update Todo record
  Future<int> updateView(Views views) async {
    final db = await dbProvider.database;

    var result = await db.update(tblview, views.toMap(),
        where: "id = ?", whereArgs: [views.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteView(int id) async {
    final db = await dbProvider.database;
    var result = await db
        .delete(tblview, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllViews() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      tblview,
    );

    return result;
  }
}
