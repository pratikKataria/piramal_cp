/// returnCode : true
/// message : "SUCCESS"
/// AvailabilityStatus : "Attend"

class CpEventStatusUpdateResponse {
  CpEventStatusUpdateResponse({
      bool returnCode, 
      String message, 
      String availabilityStatus,}){
    _returnCode = returnCode;
    _message = message;
    _availabilityStatus = availabilityStatus;
}

  CpEventStatusUpdateResponse.fromJson(dynamic json) {
    _returnCode = json['returnCode'];
    _message = json['message'];
    _availabilityStatus = json['AvailabilityStatus'];
  }
  bool _returnCode;
  String _message;
  String _availabilityStatus;

  bool get returnCode => _returnCode;
  String get message => _message;
  String get availabilityStatus => _availabilityStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['returnCode'] = _returnCode;
    map['message'] = _message;
    map['AvailabilityStatus'] = _availabilityStatus;
    return map;
  }

}