/// sfdcid : "a2xp0000000ewiNAAQ"
/// returnCode : true
/// ProjectInterested : "Piramal Aranya"
/// Name : "CP Lead 6"
/// MobileNumber : "9960390022"
/// message : "Success"

class AllLeadResponse {
  AllLeadResponse({
      String sfdcid, 
      bool returnCode, 
      String projectInterested, 
      String name, 
      String mobileNumber, 
      String message,}){
    _sfdcid = sfdcid;
    _returnCode = returnCode;
    _projectInterested = projectInterested;
    _name = name;
    _mobileNumber = mobileNumber;
    _message = message;
}

  AllLeadResponse.fromJson(dynamic json) {
    _sfdcid = json['sfdcid'];
    _returnCode = json['returnCode'];
    _projectInterested = json['ProjectInterested'];
    _name = json['Name'];
    _mobileNumber = json['MobileNumber'];
    _message = json['message'];
  }
  String _sfdcid;
  bool _returnCode;
  String _projectInterested;
  String _name;
  String _mobileNumber;
  String _message;

  String get sfdcid => _sfdcid;
  bool get returnCode => _returnCode;
  String get projectInterested => _projectInterested;
  String get name => _name;
  String get mobileNumber => _mobileNumber;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sfdcid'] = _sfdcid;
    map['returnCode'] = _returnCode;
    map['ProjectInterested'] = _projectInterested;
    map['Name'] = _name;
    map['MobileNumber'] = _mobileNumber;
    map['message'] = _message;
    return map;
  }

}