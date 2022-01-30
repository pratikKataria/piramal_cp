/// message : "Session expired or invalid"
/// errorCode : "INVALID_SESSION_ID"

class ApiErrorModel {
  ApiErrorModel({
      String message, 
      String errorCode,}){
    _message = message;
    _errorCode = errorCode;
}

  ApiErrorModel.fromJson(dynamic json) {
    _message = json['message'];
    _errorCode = json['errorCode'];
  }
  String _message;
  String _errorCode;

  String get message => _message;
  String get errorCode => _errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['errorCode'] = _errorCode;
    return map;
  }

}