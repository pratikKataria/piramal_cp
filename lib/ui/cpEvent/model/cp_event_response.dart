/// returnCode : true
/// message : "SUCCESS"
/// EventName : "test event"
/// EventImage : "this is a test image "
/// EventDatetime : "2022-01-25T10:06:00.000Z"
/// cpeventId : "a2yp0000000fOXZAA2"
/// Availabilitystatus : "Tentative"

class CpEventResponse {
  CpEventResponse({
      bool returnCode, 
      String message, 
      String eventName, 
      String eventImage, 
      String eventDatetime, 
      String cpeventId, 
      String availabilitystatus,}){
    _returnCode = returnCode;
    _message = message;
    _eventName = eventName;
    _eventImage = eventImage;
    _eventDatetime = eventDatetime;
    _cpeventId = cpeventId;
    _availabilitystatus = availabilitystatus;
}

  CpEventResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _eventName = json['EventName'];
    _eventImage = json['EventImage'];
    _eventDatetime = json['EventDatetime'];
    _cpeventId = json['cpeventId'];
    _availabilitystatus = json['Availabilitystatus'];
  }
  bool _returnCode;
  String _message;
  String _eventName;
  String _eventImage;
  String _eventDatetime;
  String _cpeventId;
  String _availabilitystatus;

  bool get returnCode => _returnCode;
  String get message => _message;
  String get eventName => _eventName;
  String get eventImage => _eventImage;
  String get eventDatetime => _eventDatetime;
  String get cpeventId => _cpeventId;
  String get availabilitystatus => _availabilitystatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['EventName'] = _eventName;
    map['EventImage'] = _eventImage;
    map['EventDatetime'] = _eventDatetime;
    map['cpeventId'] = _cpeventId;
    map['Availabilitystatus'] = _availabilitystatus;
    return map;
  }

  set availabilitystatus(String value) {
    _availabilitystatus = value;
  }

  set cpeventId(String value) {
    _cpeventId = value;
  }

  set eventDatetime(String value) {
    _eventDatetime = value;
  }

  set eventImage(String value) {
    _eventImage = value;
  }

  set eventName(String value) {
    _eventName = value;
  }

  set message(String value) {
    _message = value;
  }

  set returnCode(bool value) {
    _returnCode = value;
  }
}