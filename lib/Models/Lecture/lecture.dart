class Lecture {
  Lecture({
    this.id,
    this.lectureId,
    this.content,
    this.title,
    this.file,
    this.description,
    this.chapterNo,
  });

  int id;
  String lectureId;
  String content;
  String title;
  String file;
  String description;
  String chapterNo;

  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
        id: json["id"],
        lectureId: json["lectureId"],
        content: json["content"],
        title: json["title"],
        file: json["file"],
        description: json["description"],
        chapterNo: json["chapterNo"],
      );

  factory Lecture.fromMap(Map<String, dynamic> json) => Lecture(
        id: json["id"],
        lectureId: json["lectureId"],
        content: json["content"],
        title: json["title"],
        file: json["file"],
        description: json["description"],
        chapterNo: json["chapterNo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lectureId": lectureId,
        "content": content,
        "title": title,
        "file": file,
        "description": description,
        "chapterNo": chapterNo,
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "lectureId": lectureId,
        "content": content,
        "title": title,
        "file": file,
        "description": description,
        "chapterNo": chapterNo,
      };
}
