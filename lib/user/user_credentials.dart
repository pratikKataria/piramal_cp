/// TnCFlag : false
/// returnCode : 2
/// message : "Email Login Succesfull"
/// AccountId : "0010l00001BwGl6AAF"

class UserCredentials {
  bool _tnCFlag;
  int _returnCode;
  String _message;
  String _accountId;

  bool get tnCFlag => _tnCFlag;

  int get returnCode => _returnCode;

  String get message => _message;

  String get accountId => _accountId;

  UserCredentials({bool tnCFlag, int returnCode, String message, String accountId}) {
    _tnCFlag = tnCFlag;
    _returnCode = returnCode;
    _message = message;
    _accountId = accountId;
  }

  UserCredentials.fromMap(dynamic json) {
    _tnCFlag = json != null ? json["TnCFlag"] : false;
    _returnCode = json != null ? json["returnCode"] : 12;
    _message = json != null ? json["message"] : "";
    _accountId = json != null ? json["AccountId"] : "";
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["TnCFlag"] = _tnCFlag;
    map["returnCode"] = _returnCode;
    map["message"] = _message;
    map["AccountId"] = _accountId;
    return map;
  }
}
