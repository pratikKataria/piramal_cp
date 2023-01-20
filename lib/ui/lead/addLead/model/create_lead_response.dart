/// returnCode : 0
/// recordid : "a2xp0000000exFSAAY"
/// message : "SUCCESS"
/// l : null

class CreateLeadResponse {
  CreateLeadResponse({
    bool returnCode,
    String recordid,
    String message,
    dynamic l,
  }) {
    _returnCode = returnCode;
    _recordid = recordid;
    _message = message;
    _l = l;
  }

  CreateLeadResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _recordid = json['recordid'];
    _message = json['message'];
    _l = json['l'];
  }

  bool _returnCode;
  String _recordid;
  String _message;
  dynamic _l;

  bool get returnCode => _returnCode;
  String get recordid => _recordid;
  String get message => _message;

  dynamic get l => _l;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['recordid'] = _recordid;
    map['message'] = _message;
    map['l'] = _l;
    return map;
  }
}
