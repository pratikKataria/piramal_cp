/// values : "SFDC TEST.CASE1,SFDC TEST.CASE2,SM Mahalaxmi,Mr. Aditya RM,Pawan\nDhameja,Viral Nandu,Aniket Patil,null"
/// returnCode : true
/// message : "Success"
/// fieldName : "RelationshipManager"

class RelationManagerListResponse {
  RelationManagerListResponse({
      String values, 
      bool returnCode, 
      String message, 
      String fieldName,}){
    _values = values;
    _returnCode = returnCode;
    _message = message;
    _fieldName = fieldName;
}

  RelationManagerListResponse.fromJson(dynamic json) {
    _values = json['values'];
    _returnCode = json['returnCode'];
    _message = json['message'];
    _fieldName = json['fieldName'];
  }
  String _values;
  bool _returnCode;
  String _message;
  String _fieldName;

  String get values => _values;
  bool get returnCode => _returnCode;
  String get message => _message;
  String get fieldName => _fieldName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['values'] = _values;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['fieldName'] = _fieldName;
    return map;
  }

}