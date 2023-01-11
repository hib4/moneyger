class ChatModel {
  String _text;
  bool _isAnswer;

  ChatModel(this._text, this._isAnswer);

  bool get isAnswer => _isAnswer;

  set isAnswer(bool value) {
    _isAnswer = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }
}
