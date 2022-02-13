/// values : "3 BHK ,2 BHK ,1 BHK ,null"
/// fieldName : "Configuration__c"

class PickListResponse {
  PickListResponse({
      String values, 
      String fieldName,}){
    _values = values;
    _fieldName = fieldName;
}

  PickListResponse.fromJson(dynamic json) {
    _values = json['values'];
    _fieldName = json['fieldName'];
  }
  String _values;
  String _fieldName;

  String get values => _values;
  String get fieldName => _fieldName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['values'] = _values;
    map['fieldName'] = _fieldName;
    return map;
  }

  set fieldName(String value) {
    _fieldName = value;
  }

  set values(String value) {
    _values = value;
  }
}