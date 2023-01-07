class Number_DTO{
  int? _id;
  String? _title;
  String? _subTile;
  String? _content;


  int get id => _id ?? 0;

  set id(int value) {
    _id = value;
  }

  String get title => _title ?? "";

  String get content => _content ?? "";

  set content(String value) {
    _content = value;
  }

  String get subTile => _subTile ?? "";

  set subTile(String value) {
    _subTile = value;
  }

  set title(String value) {
    _title = value;
  }

  @override
  String toString() {
    return 'Number_DTO{_id: $_id, _title: $_title, _subTile: $_subTile, _content: $_content}';
  }

  Number_DTO.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _subTile = json['subtitle'];
    _id = json['id'];
    _content = json['content'];
  }

  static Number_DTO parser (Map<String, dynamic> json){
    return Number_DTO.fromJson(json);
  }
}