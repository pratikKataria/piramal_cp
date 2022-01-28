/// returnCode : 2
/// message : "Login Succesfull"
/// Is_Customer : true
/// AccountId : "001N000001S7nkdIAB"

class LoginResponse {
  LoginResponse({
    bool returnCode,
    String message,
    bool isCustomer,
    String accountId,
  }) {
    _returnCode = returnCode;
    _message = message;
    _isCustomer = isCustomer;
    _accountId = accountId;
  }

  LoginResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _isCustomer = json['Is_Customer'];
    _accountId = json['AccountId'];
  }

  bool _returnCode;
  String _message;
  bool _isCustomer;
  String _accountId;

  bool get returnCode => _returnCode;

  String get message => _message;

  bool get isCustomer => _isCustomer;

  String get accountId => _accountId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['Is_Customer'] = _isCustomer;
    map['AccountId'] = _accountId;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'returnCode': this._returnCode,
      'message': this._message,
      'isCustomer': this._isCustomer,
      'accountId': this._accountId,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      returnCode: map != null ? map['returnCode'] as bool : null,
      message: map != null ? map['message'] as String : null,
      isCustomer: map != null ? map['isCustomer'] as bool : null,
      accountId: map != null ? map['accountId'] as String : null,
    );
  }
}
