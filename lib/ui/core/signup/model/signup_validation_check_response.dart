/// returnCode : true
/// message : "Account with same Email already exists !! "
/// isDuplicate : true

class SignupValidationCheckResponse {
  SignupValidationCheckResponse({
      bool returnCode, 
      String message, 
      bool isDuplicate,}){
    _returnCode = returnCode;
    _message = message;
    _isDuplicate = isDuplicate;
}

  SignupValidationCheckResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _isDuplicate = json['isDuplicate'];
  }
  bool _returnCode;
  String _message;
  bool _isDuplicate;

  bool get returnCode => _returnCode;
  String get message => _message;
  bool get isDuplicate => _isDuplicate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['isDuplicate'] = _isDuplicate;
    return map;
  }

}