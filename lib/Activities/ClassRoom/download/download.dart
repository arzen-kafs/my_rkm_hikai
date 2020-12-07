import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadPage extends StatefulWidget {
  DownloadPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  int progress = 0;
  var id;
  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$progress",
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(
              height: 60,
            ),
            FlatButton(
              child: Text("Start Downloading"),
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () async {
                final status = await Permission.storage.request();

                if (status.isGranted) {
                  final externalDir = await getExternalStorageDirectory();

                  id = await FlutterDownloader.enqueue(
                    url:
                        "https:\/\/rkmhikai.online\/ClassRoom\/public\/media\/CLAI\/lectures\/CLAI-01\/videos\/CLAI-01-01\/a8664eebc4eafd4c4c8010771172ecc5.mp4",
                    savedDir: externalDir.path,
                    fileName: "a8664eebc4eafd4c4c8010771172ecc5.mp4",
                    showNotification: true,
                    openFileFromNotification: false,
                  );
                } else {
                  print("Permission deined");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
