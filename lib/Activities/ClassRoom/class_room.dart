import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:my_rkm_hikai/Activities/ClassRoom/video_player/bloc/video_bloc.dart';
import 'package:my_rkm_hikai/Activities/ClassRoom/video_player/hikai_player.dart';
import 'package:my_rkm_hikai/Activities/SyncHikaiPage/bloc/chapter_bloc.dart';
import 'package:my_rkm_hikai/Activities/SyncHikaiPage/bloc/lecture_bloc.dart';
import 'package:my_rkm_hikai/Models/Chapter/chapter.dart';
import 'package:my_rkm_hikai/Models/Lecture/lecture.dart';
import 'package:my_rkm_hikai/core/session.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:video_player/video_player.dart';

import 'download/bloc/download_bloc.dart';

const ASPECT_RATIO = 3 / 2;

class ClassRoomPage extends StatefulWidget {
  ClassRoomPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ClassRoomPageState createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {
  final videobloc = VideoBloc();
  final chapterBloc = ChapterBloc();
  final lectureBloc = LectureBloc();
  final downloadBloc = DownloadBloc();
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  Session session = Session();
  int progress = 0;
  var downlaodTask;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    connectionSetUp();
    loadvideo();
  }

  connectionSetUp() {
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      print("======CONNECTION===========");
      print(_connectionStatus);

      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {});
      }
    });
  }

  loadvideo() async {
    String videofile = await session.getString("videofile") ?? null;
    String videotitle = await session.getString("videotitle") ?? null;
    if (videofile != null && videotitle != null) {
      print("======PREF========");
      print(videofile);
      print(videotitle);
      videobloc.urlSink.add([videofile, videotitle]);
    } else {
      print("==========LOADING FAIL===============");
    }
  }

  static void downloadCallback(
      downlaodTask, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([downlaodTask, status, progress]);
  }

  void _bindBackgroundIsolate() {
    print("============DOWNLOAD1=========");
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    print("=============PORT===============");
    print(isSuccess);
    if (!isSuccess) {
      print("============DOWNLOAD1Inside=========");
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      progress = data[2];
      print("=========DOWNLOAD2Before========");
      print("=========DOWNLOAD2STATUS========");
      print(status == DownloadTaskStatus.running);

      if (status == DownloadTaskStatus.complete) {
        downloadBloc.downloadStatusSink.add(3);
      }

      print("============PROGRESS==========");
      print(progress);
      if (progress == 100) {
        // downloadBloc.downloadStatusSink.add(false);
      }
      // if (status == DownloadTaskStatus.complete) {
      //   downloadBloc.downloadStatusSink.add(false);
      // }
      print("============PROGRESS==========");
      // setState(() {
      //   if (id == downlaodTask) {
      //     this.progress = progress;

      //     if (status == DownloadTaskStatus.complete) {
      //       downloadBloc.downloadStatusSink.add(false);
      //     }
      //   }
      // });
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping("downloader_send_port");
  }

  File videoFile = File(
      "/storage/emulated/0/Android/data/com.example.flutter_myvideoplayer/files/CLAI\/lectures\/CLAI-01\/videos\/CLAI-01-01\/a8664eebc4eafd4c4c8010771172ecc5.mp4");
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHeight = screenWidth / ASPECT_RATIO;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: containerHeight,
              child: StreamBuilder(
                stream: videobloc.urlStream,
                initialData: [
                  "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
                  "Sample"
                ],
                builder: (content, snapshot) {
                  bool fileAvail = File(snapshot.data[0]).existsSync();
                  if (fileAvail) {
                    File videoPath = File(snapshot.data[0]);
                    return VideoPlayerWidget(
                      controller: VideoPlayerController.file(videoPath),
                      videoTitle: snapshot.data[1],
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "VIDEO NOT FOUND",
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Icon(
                            Icons.wifi,
                            size: 40.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "PLEASE DOWNLOAD",
                            style: Theme.of(context).textTheme.title,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Lectures',
                  ),
                ], // list of tabs
              ),
            ),
            //TabBarView(children: [ImageList(),])
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    color: Colors.white,
                    child: getChapterWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getChapterWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: chapterBloc.chapter,
      builder:
          (BuildContext context, AsyncSnapshot<List<Chapter>> snapshotChapter) {
        return StreamBuilder(
          stream: lectureBloc.lecture,
          builder: (BuildContext context,
              AsyncSnapshot<List<Lecture>> snapshotLecture) {
            if (snapshotChapter.hasData && snapshotLecture.hasData) {
              print(snapshotChapter.data.length);
              print(snapshotLecture.data.length);
              // videobloc.urlSink.add([
              //   "${snapshotLecture.data[0].file}",
              //   "${snapshotLecture.data[0].title}"
              // ]);
              return getChapterListWidget(snapshotChapter, snapshotLecture);
            } else {
              return Text("Please wait");
            }
          },
        );
      },
    );
  }

//getChapterListWidget(snapshot);
  Widget getChapterListWidget(AsyncSnapshot<List<Chapter>> snapshotChapter,
      AsyncSnapshot<List<Lecture>> snapshotLecture) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshotChapter.hasData && snapshotLecture.hasData) {
      // List<bool> boolList = [];

      // bool downloadingStatus = false;
      print("${snapshotChapter.data.length}");
      print("#########################################");
      Map<String, List<bool>> _selectedChapter = {};
      return ListView.builder(
        itemCount: snapshotChapter.data.length,
        itemBuilder: (context, chapterIndex) {
          Chapter chapter = snapshotChapter.data[chapterIndex];
          List<Lecture> snapshotLectureByChapter = [];

          for (int i = 0; i < snapshotLecture.data.length; i++) {
            if (chapter.chapterNo == snapshotLecture.data[i].chapterNo) {
              print("${chapter.chapterNo} =>  ${snapshotLecture.data[i].file}");
              snapshotLectureByChapter.add(snapshotLecture.data[i]);
            }
          }
          List<bool> _selected =
              List.generate(snapshotLectureByChapter.length, (i) => false);
          bool containsKey =
              _selectedChapter.containsKey("${chapter.chapterNo}");
          if (!containsKey) {
            _selectedChapter.addAll({"${chapter.chapterNo}": _selected});
          }

          var selectedChapter = _selectedChapter["CLAI-01"][0];
          print(selectedChapter);
          // _selectedChapter["${chapter.chapterNo}"] = _selected;
          // initially fill it up with false
          print("=============MAP=================");
          print(_selectedChapter.toString());
          return Column(
            children: [
              ListTile(
                leading: Icon(Icons.local_play_outlined),
                title: Text(
                  "${chapterIndex + 1}  ${chapter.title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "Total Lectures: ${chapter.items}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                itemBuilder: (context, lectureIndex) {
                  Lecture lecture = snapshotLectureByChapter[lectureIndex];

                  bool fileAvail = File(
                          "/storage/emulated/0/Android/data/online.rkmhikai/files/${lecture.file}")
                      .existsSync();
                  // if (fileAvail) {
                  //   boolList.add(true);
                  // } else {
                  //   boolList.add(false);
                  // }
                  // print("============");
                  // print(boolList.length);
                  // print(boolList.toString());

                  return StreamBuilder<List<dynamic>>(
                      stream: lectureBloc.lectureSelectedStream,
                      initialData: ["CLAI-01", 0],
                      builder: (context, snapshot) {
                        String selChapterNo = snapshot.data[0];
                        int selLectureIndex = snapshot.data[1];
                        if (lecture.chapterNo == selChapterNo &&
                            lectureIndex == selLectureIndex) {
                          _selectedChapter[selChapterNo][selLectureIndex] =
                              true;
                        }
                        print("================PRINT-MAP================");
                        print(_selectedChapter.toString());
                        print(
                            _selectedChapter[lecture.chapterNo][lectureIndex]);
                        // var data =
                        //     _selectedChapter[lecture.chapterNo][lectureIndex];
                        // print(_selected);
                        return Container(
                          color: _selectedChapter[lecture.chapterNo]
                                  [lectureIndex]
                              ? Colors.orange
                              : Colors.white,
                          child: ListTile(
                            leading: lecture.content == "video"
                                ? Icon(Icons.play_circle_fill)
                                : Icon(Icons.book),
                            title: Text("${lecture.title}"),
                            trailing: fileAvail
                                ? IconButton(
                                    icon: Icon(
                                      Icons.check_box,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      print("Downloaded");
                                    },
                                  )
                                : StreamBuilder<int>(
                                    stream: downloadBloc.downloadStatusStream,
                                    initialData: 0,
                                    builder: (context, snapshot) {
                                      print("Download Status${snapshot.data}");
                                      if (snapshot.data == 0) {
                                        return IconButton(
                                          icon: Icon(
                                              Icons.cloud_download_outlined),
                                          onPressed: () {
                                            print("Download...............");
                                            downloadVideo("${lecture.title}",
                                                "${lecture.file}");
                                            downloadBloc.downloadStatusSink
                                                .add(1);
                                          },
                                        );
                                      } else if (snapshot.data == 1) {
                                        return SizedBox(
                                            height: 20.0,
                                            width: 20.0,
                                            child: CircularProgressIndicator());
                                      } else {
                                        return IconButton(
                                          icon: Icon(
                                            Icons.check_box,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            print("Downloaded");
                                          },
                                        );
                                      }
                                    }),
                            onTap: () async {
                              // int urlLenght = lecture.file.length;
                              // String urlVideo = lecture.file.substring(47, urlLenght);
                              final externalDir =
                                  await getExternalStorageDirectory();
                              print(externalDir.path + "${lecture.file}");
                              print("${lecture.file}");
                              String file =
                                  externalDir.path + "${lecture.file}";
                              videobloc.urlSink.add([file, "${lecture.title}"]);
                              print("=========1SESSION===========");

                              session.addString("videofile", file);
                              session.addString(
                                  "videotitle", "${lecture.title}");

                              String value1 =
                                  await session.getString("videofile") ?? "";
                              print(value1);
                              String value2 =
                                  await session.getString("videotitle") ?? "";
                              print(value2);
                              print("====================");
                              session
                                  .getString("videofile")
                                  .then((value) => print(value));
                              session
                                  .getString("videotitle")
                                  .then((value) => print(value));
                              session
                                  .isset("videofile")
                                  .then((value) => print(value));

                              print("=========2SESSION===========");
                              // _selected[lectureIndex] = !_selected[lectureIndex];
                              // print(_selected[lectureIndex]);
                              print("=======LectureINDEX");
                              print(lectureIndex);
                              // _selected[lectureIndex] =
                              //     !_selected[lectureIndex];
                              // print(_selected[lectureIndex]);
                              lectureBloc.lectureSelectedSink
                                  .add([lecture.chapterNo, lectureIndex]);
                            },
                          ),
                        );
                      });
                },
                itemCount: snapshotLectureByChapter.length,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
              )
            ],
          );
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      );
    }
  }

  void downloadVideo(String videoTitle, String videoUrl) async {
    print(videoUrl);
    String serverAddress = "https://rkmhikai.online/ClassRoom/public/media";

    final status = await Permission.storage.request();
    if (status.isGranted) {
      //online.rkmhikai ->Project Name
      final externalDir = await getExternalStorageDirectory();
      String fileName = videoUrl.split('/').last;
      int fileNameIndex = videoUrl.indexOf(fileName, 0);

      String mediaDirectory = videoUrl.substring(0, fileNameIndex - 1);
      Directory(externalDir.path + "$mediaDirectory")
          .create(recursive: true)
          .then((Directory directory) {
        print("Directory Created");
        print(directory.path);
        print("Media $mediaDirectory");
        print(externalDir);
        print(videoUrl);
        downlaodTask = FlutterDownloader.enqueue(
          url: serverAddress + videoUrl,
          savedDir: directory.path,
          fileName: fileName,
          showNotification: true,
          openFileFromNotification: false,
        );
        // _bindBackgroundIsolate();
        // FlutterDownloader.registerCallback(downloadCallback);
        print("File ${externalDir.path}");
        // FlutterDownloader.open(taskId: downlaodTask)
        //     .whenComplete(() => {downloadBloc.downloadStatusSink.add(false)});
      });
    } else {
      print("Permission deined");
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
