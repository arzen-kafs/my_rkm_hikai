import 'package:flutter/material.dart';
import 'bloc/chapter_bloc.dart';
import 'bloc/lecture_bloc.dart';

class SyncHikaiPage extends StatefulWidget {
  SyncHikaiPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SyncHikaiPageState createState() => _SyncHikaiPageState();
}

class _SyncHikaiPageState extends State<SyncHikaiPage> {
  final chapterBloc = ChapterBloc();
  final lectureBloc = LectureBloc();
  bool apiCall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: chapterBloc.fetchChapter(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('Press button to start.');
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    if (snapshot.data == null) return CircularProgressIndicator();
                }
                print("==============CAHPTER=============");
                print(snapshot.data);
                return Column(
                  children: [
                    Text("Chapter Sync Successfully to the server"),
                  ],
                );
              },
            ),
            FutureBuilder(
              future: lectureBloc.fetchLecture(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('Press button to start.');
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    if (snapshot.data == null) return CircularProgressIndicator();
                }
                print("==============LECTURE=============");
                print(snapshot.data);
                return Column(
                  children: [
                    Text("Lecture Sync Successfully to the server"),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
