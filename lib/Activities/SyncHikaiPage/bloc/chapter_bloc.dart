import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_rkm_hikai/Database/chapter_repository.dart';
import 'package:my_rkm_hikai/Models/Chapter/chapter.dart';


class ChapterBloc {
  //Get instance of the Repository
  final _chapterRepository = ChapterRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _chapterController = StreamController<List<Chapter>>.broadcast();

  get chapter => _chapterController.stream;

  ChapterBloc() {
    getChapters();
  }

  getChapters({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _chapterController.sink
        .add(await _chapterRepository.getAllChapters(query: query));
  }

  addChapter(Chapter chapter) async {
    await _chapterRepository.insertChapter(chapter);
    getChapters();
  }

  updateChapter(Chapter chapter) async {
    await _chapterRepository.updateChapter(chapter);
    getChapters();
  }

  deleteChapterByChapterNo(String chapterNo) async {
    _chapterRepository.deleteChapterBychapterNo(chapterNo);
    getChapters();
  }

  dispose() {
    _chapterController.close();
  }

  Future<List<Chapter>> fetchChapter() async {
    _chapterRepository.deleteAllChapters();
    final response =
        await http.get("https://rkmhikai.online/ClassRoom/cache/CLAI.cache");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = json.decode(response.body);

      List<Chapter> chapterList = [];
      for (var data in jsonData) {
        print("**************************");
        print(data);
        Chapter chapter = Chapter(
          chapterNo: data["chapterNo"],
          title: data["title"],
          ebook: data["ebook"],
          items: data["items"],
        );
        _chapterRepository.insertChapter(chapter);
        chapterList.add(chapter);
      }
      return chapterList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
