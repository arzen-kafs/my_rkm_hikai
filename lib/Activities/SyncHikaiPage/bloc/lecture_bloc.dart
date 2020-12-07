import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_rkm_hikai/Database/lecture_repository.dart';
import 'package:my_rkm_hikai/Models/Lecture/lecture.dart';


class LectureBloc {
  //Get instance of the Repository
  final _lectureRepository = LectureRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers

  final _lectureSelectedController =
      StreamController<List<dynamic>>.broadcast();
  StreamSink<List<dynamic>> get lectureSelectedSink =>
      _lectureSelectedController.sink;
  Stream<List<dynamic>> get lectureSelectedStream =>
      _lectureSelectedController.stream;

  final _lectureController = StreamController<List<Lecture>>.broadcast();

  get lecture => _lectureController.stream;

  LectureBloc() {
    getLectures();
  }

  getLectures({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _lectureController.sink
        .add(await _lectureRepository.getAllLectures(query: query));
  }

  addLecture(Lecture lecture) async {
    await _lectureRepository.insertLecture(lecture);
    getLectures();
  }

  updateLecture(Lecture lecture) async {
    await _lectureRepository.updateLecture(lecture);
    getLectures();
  }

  deleteLectureByLectureID(String lectureID) async {
    _lectureRepository.deleteLectureByLectureID(lectureID);
    getLectures();
  }

  dispose() {
    _lectureController.close();
    _lectureSelectedController.close();
  }

  Future<List<Lecture>> fetchLecture() async {
    _lectureRepository.deleteAllLectures();
    print("Lecture Top");
    final response =
        await http.get("https://rkmhikai.online/ClassRoom/cache/CLAI.cache");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = json.decode(response.body);
      print("Lecture Data");
      List<Lecture> lectureList = [];

      for (var data in jsonData) {
        var chapterNo = data["chapterNo"];
        for (var lectureData in data["lecture"]) {
          String urlAddress = lectureData["file"];
          String start = "media";
          int startIndex = urlAddress.indexOf(start);
          String mediaPath = urlAddress.substring(
              startIndex + start.length, urlAddress.length);
          print(mediaPath);
          Lecture lecture = Lecture(
            id: lectureData["id"],
            lectureId: lectureData["lectureId"],
            content: lectureData["content"],
            title: lectureData["title"],
            file: mediaPath,
            description: lectureData["description"],
            chapterNo: chapterNo,
          );
          _lectureRepository.insertLecture(lecture);
          lectureList.add(lecture);
        }
      }
      return lectureList;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
