class Chapter {
  Chapter({this.chapterNo, this.title, this.ebook, this.items});

  String chapterNo;
  String title;
  String ebook;
  int items;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterNo: json["chapterNo"],
        title: json["title"],
        ebook: json["ebook"],
        items: json["items"],
      );

  factory Chapter.fromMap(Map<String, dynamic> map) => Chapter(
        chapterNo: map["chapterNo"],
        title: map["title"],
        ebook: map["ebook"],
        items: map["items"],
      );

  Map<String, dynamic> toJson() => {
        "chapterNo": chapterNo,
        "title": title,
        "ebook": ebook,
        "items": items,
      };

  Map<String, dynamic> toMap() => {
        "chapterNo": chapterNo,
        "title": title,
        "ebook": ebook,
        "items": items,
      };
}
