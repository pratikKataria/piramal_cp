/// returnCode : false
/// message : "Please Enter correct Availability_status__c picklist values( Attend/Tentative/Not Going) "

class UpdatePaxSizeResponse {
  UpdatePaxSizeResponse({
      bool returnCode, 
      String message,}){
    _returnCode = returnCode;
    _message = message;
}

  UpdatePaxSizeResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
  }
  bool _returnCode;
  String _message;
UpdatePaxSizeResponse copyWith({  bool returnCode,
  String message,
}) => UpdatePaxSizeResponse(  returnCode: returnCode ?? _returnCode,
  message: message ?? _message,
);
  bool get returnCode => _returnCode;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}