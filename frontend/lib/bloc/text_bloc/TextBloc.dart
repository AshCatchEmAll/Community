import 'dart:async';

class TextBloc {
  var _textController = StreamController<String>();
  String _text = "";
  Stream<String> get textStream => _textController.stream;
  updateText(String text) {
    (text == null || text == "")
        ? _textController.sink.addError("Invalid value entered!")
        : _text = text;
  }

  getText() {
    String t = _text;
    return t;
  }

  clearText() {
    _text = "";
  }

  dispose() {
    _textController.close();
  }
}
