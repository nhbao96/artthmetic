class NumberModel{
  int? _id;
  String? _title;
  String? _subTitle;
  String? _content;

  NumberModel(this._id, this._title, this._subTitle, this._content);

  String get content => _content ?? "";

  set content(String value) {
    _content = value;
  }

  String get subTitle => _subTitle ?? "";

  set subTitle(String value) {
    _subTitle = value;
  }

  String get title => _title ?? "";

  set title(String value) {
    _title = value;
  }

  int get id => _id ?? 0;

  set id(int value) {
    _id = value;
  }

  @override
  String toString() {
    return 'NumberModel{_id: $_id, _title: $_title, _subTitle: $_subTitle, _content: $_content}';
  }
}