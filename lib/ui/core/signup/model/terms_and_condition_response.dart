/// TermsAndCondition : "I accept the terms and condition as declared as follow:1.will abide with the rules and regulation set by the company and will follow all norms and Guideline set by the company."
/// returnCode : true
/// message : "success"

class TermsAndConditionResponse {
  TermsAndConditionResponse({
      String termsAndCondition, 
      bool returnCode, 
      String message,}){
    _termsAndCondition = termsAndCondition;
    _returnCode = returnCode;
    _message = message;
}

  TermsAndConditionResponse.fromJson(dynamic json) {
    _termsAndCondition = json['TermsAndCondition'];
    _returnCode = json['returnCode'];
    _message = json['message'];
  }
  String _termsAndCondition;
  bool _returnCode;
  String _message;

  String get termsAndCondition => _termsAndCondition;
  bool get returnCode => _returnCode;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TermsAndCondition'] = _termsAndCondition;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}