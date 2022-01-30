/// returnCode : true
/// recordid : "00Tp000000Hp4UGEAZ"
/// message : "SUCCESS"
/// Dateofvisit : null

class ScheduleVisitResponse {
  ScheduleVisitResponse({
      bool returnCode,
      String recordid,
      String message,
      dynamic dateofvisit,}){
    _returnCode = returnCode;
    _recordid = recordid;
    _message = message;
    _dateofvisit = dateofvisit;
}

  ScheduleVisitResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _recordid = json['recordid'];
    _message = json['message'];
    _dateofvisit = json['Dateofvisit'];
  }
  bool _returnCode;
  String _recordid;
  String _message;
  dynamic _dateofvisit;

  bool get returnCode => _returnCode;
  String get recordid => _recordid;
  String get message => _message;
  dynamic get dateofvisit => _dateofvisit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['recordid'] = _recordid;
    map['message'] = _message;
    map['Dateofvisit'] = _dateofvisit;
    return map;
  }

}