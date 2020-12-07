import 'dart:async';

class VideoBloc {
  final _stateStreamController = StreamController<List<String>>.broadcast();
  StreamSink<List<String>> get urlSink => _stateStreamController.sink;
  Stream<List<String>> get urlStream => _stateStreamController.stream;

  void dispose() {
    _stateStreamController.close();
  }
}
