import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Notice extends StatefulWidget {
  @override
  NoticeState createState() => NoticeState();
}

class NoticeState extends State<Notice> {
  // @override
  // void initState() {
  //   super.initState();
  //   // Enable hybrid composition.
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notice Board"),
      ),
      body: WebView(
        initialUrl: 'https://rkmhikai.online/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
