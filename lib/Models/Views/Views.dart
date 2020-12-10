class Views {
  Views({this.id, this.lectureId, this.numberview, this.date});

  int id;
  String lectureId;
  int numberview;
  int date;

  factory Views.fromMap(Map<String, dynamic> map) => Views(
    id: map["id"],
    lectureId: map["lectureId"],
    numberview: map["numberview"],
    date: map["date"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "lectureId": lectureId,
    "numberview": numberview,
    "date": date,
  };
}