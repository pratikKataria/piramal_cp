/// values : "Others,GST/tax related,Invoice acceptance acknowledgement,Delay in payment,null"
/// returnCode : true
/// message : "success"
/// fieldName : "Case SubType"

class CaseSubtypeResponse {
  CaseSubtypeResponse({
      String values, 
      bool returnCode, 
      String message, 
      String fieldName,}){
    _values = values;
    _returnCode = returnCode;
    _message = message;
    _fieldName = fieldName;
}

  CaseSubtypeResponse.fromJson(dynamic json) {
    _values = json['values'];
    _returnCode = json['returnCode'];
    _message = json['message'];
    _fieldName = json['fieldName'];
  }
  String _values;
  bool _returnCode;
  String _message;
  String _fieldName;
CaseSubtypeResponse copyWith({  String values,
  bool returnCode,
  String message,
  String fieldName,
}) => CaseSubtypeResponse(  values: values ?? _values,
  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
  fieldName: fieldName ?? _fieldName,
);
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