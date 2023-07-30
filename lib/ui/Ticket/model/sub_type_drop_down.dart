/// selected : false
/// value : ""

class SubTypeDropDown {
  SubTypeDropDown({
    bool selected,
    String value,
  }) {
    _selected = selected;
    _value = value;
  }

  SubTypeDropDown.fromJson(dynamic json) {
    _selected = json['selected'];
    _value = json['value'];
  }

  bool _selected;
  String _value;

  SubTypeDropDown copyWith({
    bool selected,
    String value,
  }) =>
      SubTypeDropDown(
        selected: selected,
        value: value,
      );

  bool get selected => _selected ?? false;

  String get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['selected'] = _selected;
    map['value'] = _value;
    return map;
  }

  set value(String value) {
    _value = value;
  }

  set selected(bool value) {
    _selected = value;
  }
}
