/// returnCode : true
/// message : "SUCCESS"
/// CustomerAccountID : "001p000000zIxLFAA0"
/// ApplicationStatus : "Approved"

class AccountStatusResponse {
  AccountStatusResponse({
      bool returnCode, 
      String message, 
      String customerAccountID, 
      String applicationStatus,}){
    _returnCode = returnCode;
    _message = message;
    _customerAccountID = customerAccountID;
    _applicationStatus = applicationStatus;
}

  AccountStatusResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _customerAccountID = json['CustomerAccountID'];
    _applicationStatus = json['ApplicationStatus'];
  }

  bool _returnCode;
  String _message;
  String _customerAccountID;
  String _applicationStatus;

  bool get returnCode => _returnCode;
  String get message => _message;
  String get customerAccountID => _customerAccountID;
  String get applicationStatus => _applicationStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['CustomerAccountID'] = _customerAccountID;
    map['ApplicationStatus'] = _applicationStatus;
    return map;
  }

}