/// returnCode : 204
/// message : "Successfully Deleted"

class DeleteLeadResponse {
  String leadId;
  DeleteLeadResponse({
      bool returnCode,
      String message,}){
    _returnCode = returnCode;
    _message = message;
}

  DeleteLeadResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
  }
  bool _returnCode;
  String _message;

  bool get returnCode => _returnCode;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    return map;
  }

}