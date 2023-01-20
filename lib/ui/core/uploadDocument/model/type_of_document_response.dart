/// values : "Others,GST Certificate,Address Proof,PAN,RERA Certificate,null"
/// returnCode : true
/// message : "success"

class TypeOfDocumentResponse {
  TypeOfDocumentResponse({
      String values, 
      bool returnCode, 
      String message,}){
    _values = values;
    _returnCode = returnCode;
    _message = message;
}

  TypeOfDocumentResponse.fromJson(dynamic json) {
    _values = json['values'];
    _returnCode = json['returnCode'];
    _message = json['message'];
  }
  String _values;
  bool _returnCode;
  String _message;

  String get values => _values;
  bool get returnCode => _returnCode;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['values'] = _values;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}