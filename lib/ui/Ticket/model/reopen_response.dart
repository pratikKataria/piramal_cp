/// status : null
/// returnCode : false
/// Reason : ""
/// message : " This is not a closed case "

class ReopenResponse {
  ReopenResponse({
    dynamic status,
    bool returnCode,
    String reason,
    String message,
  }) {
    _status = status;
    _returnCode = returnCode;
    _reason = reason;
    _message = message;
  }

  ReopenResponse.fromJson(dynamic json) {
    _status = json['status'];
    _returnCode = json['returnCode'];
    _reason = json['Reason'];
    _message = json['message'];
  }

  dynamic _status;
  bool _returnCode;
  String _reason;
  String _message;

  ReopenResponse copyWith({
    dynamic status,
    bool returnCode,
    String reason,
    String message,
  }) =>
      ReopenResponse(
        status: status,
        returnCode: returnCode,
        reason: reason,
        message: message,
      );

  dynamic get status => _status;

  bool get returnCode => _returnCode;

  String get reason => _reason;

  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['returnCode'] = _returnCode;
    map['Reason'] = _reason;
    map['message'] = _message;
    return map;
  }
}
