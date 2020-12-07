import 'package:my_rkm_hikai/Models/Lecture/lecture.dart';
import 'lecture_dao.dart';

class LectureRepository {
  final lectureDao = LectureDao();

  Future getAllLectures({String query}) => lectureDao.getLecture(query: query);

  Future insertLecture(Lecture lecture) => lectureDao.createLecture(lecture);

  Future updateLecture(Lecture lecture) => lectureDao.updateLecture(lecture);

  Future deleteLectureByLectureID(String lectureID) =>
      lectureDao.deleteLecture(lectureID);

  //We are not going to use this in the demo
  Future deleteAllLectures() => lectureDao.deleteAllLectures();
}
