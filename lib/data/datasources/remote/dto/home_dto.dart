class HomeDTO{
  String? _title;
  String? _subTitle;
  String? _background;
  List<String>? _options;

  HomeDTO(this._title, this._subTitle, this._background, this._options);

  List<String> get options => _options ?? [];

  String get background => _background ?? "";

  String get subTitle => _subTitle ?? "";

  String get title => _title ?? "";

  set options(List<String> value) {
    _options = value;
  }

  set background(String value) {
    _background = value;
  }

  set subTitle(String value) {
    _subTitle = value;
  }

  set title(String value) {
    _title = value;
  }

  @override
  String toString() {
    return 'HomeDTO{_title: $_title, _subTitle: $_subTitle, _background: $_background, _options: $_options}';
  }

  HomeDTO.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _subTitle = json['subtitle'];
    _background = json['background'];
    _options = json['option'];
  }

  static HomeDTO parser (Map<String, dynamic> json){
    return HomeDTO.fromJson(json);
  }
}