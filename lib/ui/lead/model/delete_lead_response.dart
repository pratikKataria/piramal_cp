/// returnCode : 204
/// message : "Successfully Deleted"

class DeleteLeadResponse {
  String leadId;
  DeleteLeadResponse({
      int returnCode, 
      String message,}){
    _returnCode = returnCode;
    _message = message;
}

  DeleteLeadResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
  }
  int _returnCode;
  String _message;

  int get returnCode => _returnCode;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}