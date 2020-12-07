import 'dart:async';

class DownloadBloc {
  final _downloadStreamController = StreamController<int>.broadcast();
  StreamSink<int> get downloadStatusSink => _downloadStreamController.sink;
  Stream<int> get downloadStatusStream => _downloadStreamController.stream;

  final _downloadProgressStreamController = StreamController<int>.broadcast();
  StreamSink<int> get downloadProgressSink =>
      _downloadProgressStreamController.sink;
  Stream<int> get downloadProgressStream =>
      _downloadProgressStreamController.stream;

  final _downloadStatusController = StreamController<int>.broadcast();
  StreamSink<int> get downloadStatusCheckSink => _downloadStatusController.sink;
  Stream<int> get downloadStatusCheckStream => _downloadStatusController.stream;

  void dispose() {
    _downloadStatusController.close();
    _downloadProgressStreamController.close();
    _downloadStreamController.close();
  }
}
