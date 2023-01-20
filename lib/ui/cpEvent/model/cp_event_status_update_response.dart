/// zoomlink : "www.zoom.com"
/// returnCode : true
/// message : "SUCCESS"
/// AvailabilityStatus : "Attend"

class CpEventStatusUpdateResponse {
  CpEventStatusUpdateResponse({
      String zoomlink, 
      bool returnCode, 
      String message, 
      String availabilityStatus,}){
    _zoomlink = zoomlink;
    _returnCode = returnCode;
    _message = message;
    _availabilityStatus = availabilityStatus;
}

  CpEventStatusUpdateResponse.fromJson(dynamic json) {
    _zoomlink = json['zoomlink'];
    _returnCode = json['returnCode'];
    _message = json['message'];
    _availabilityStatus = json['AvailabilityStatus'];
  }
  String _zoomlink;
  bool _returnCode;
  String _message;
  String _availabilityStatus;

  String get zoomlink => _zoomlink;
  bool get returnCode => _returnCode;
  String get message => _message;
  String get availabilityStatus => _availabilityStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['zoomlink'] = _zoomlink;
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['AvailabilityStatus'] = _availabilityStatus;
    return map;
  }

}