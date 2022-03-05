/// token : "12345"
/// returnCode : true
/// message : "Success"

class DeviceTokenResponse {
  DeviceTokenResponse({
      String token, 
      bool returnCode, 
      String message,}){
    _token = token;
    _returnCode = returnCode;
    _message = message;
}

  DeviceTokenResponse.fromJson(dynamic json) {
    _token = json['token'];
    _returnCode = json['returnCode'];
    _message = json['message'];
  }
  String _token;
  bool _returnCode;
  String _message;

  String get token => _token;
  bool get returnCode => _returnCode;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}