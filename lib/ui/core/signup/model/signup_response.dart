/// returnCode : true
/// message : "SUCCESS account created"
/// BrokerAccountID : "001p000000zH5awAAC"

class SignupResponse {
  SignupResponse({
    bool returnCode,
    String message,
    String brokerAccountID,
  }) {
    _returnCode = returnCode;
    _message = message;
    _brokerAccountID = brokerAccountID;
  }

  SignupResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _brokerAccountID = json['MobileAppBrokerID'];
  }

  bool _returnCode;
  String _message;
  String _brokerAccountID;

  bool get returnCode => _returnCode;

  String get message => _message;

  String get brokerAccountID => _brokerAccountID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['MobileAppBrokerID'] = _brokerAccountID;
    return map;
  }
}
