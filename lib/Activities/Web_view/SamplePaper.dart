import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuestionPaper extends StatefulWidget {
  @override
  QuestionPaperState createState() => QuestionPaperState();
}

class QuestionPaperState extends State<QuestionPaper> {
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
        title: Text("Sample Questions"),
      ),
      body: WebView(
        initialUrl: 'https://rkmhikai.online/download/index',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
