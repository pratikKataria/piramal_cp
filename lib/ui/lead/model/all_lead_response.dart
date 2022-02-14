/// sfdcid : "a2xp0000000eyB1AAI"
/// returnCode : true
/// ProjectInterested : "Piramal Revanta"
/// Name : "Testing Patil"
/// MobileNumber : "7020034541"
/// message : "Success"
/// Location : "Mumbai"
/// Dateofvisit : "2022-02-11T00:00:00.000Z"
/// CustomerAccountId : "001N000001S7nkdIAB"
/// Configuration : "3 BHK"
/// Budget : "6 Cr – 8 Cr"

class AllLeadResponse {
  AllLeadResponse({
      String sfdcid, 
      bool returnCode, 
      String projectInterested, 
      String name, 
      String mobileNumber, 
      String message, 
      String location, 
      String dateofvisit, 
      String customerAccountId, 
      String configuration, 
      String budget,}){
    _sfdcid = sfdcid;
    _returnCode = returnCode;
    _projectInterested = projectInterested;
    _name = name;
    _mobileNumber = mobileNumber;
    _message = message;
    _location = location;
    _dateofvisit = dateofvisit;
    _customerAccountId = customerAccountId;
    _configuration = configuration;
    _budget = budget;
}

  AllLeadResponse.fromJson(dynamic json) {
    _sfdcid = json['sfdcid'];
    _returnCode = json['returnCode'];
    _projectInterested = json['ProjectInterested'];
    _name = json['Name'];
    _mobileNumber = json['MobileNumber'];
    _message = json['message'];
    _location = json['Location'];
    _dateofvisit = json['Dateofvisit'];
    _customerAccountId = json['CustomerAccountId'];
    _configuration = json['Configuration'];
    _budget = json['Budget'];
  }
  String _sfdcid;
  bool _returnCode;
  String _projectInterested;
  String _name;
  String _mobileNumber;
  String _message;
  String _location;
  String _dateofvisit;
  String _customerAccountId;
  String _configuration;
  String _budget;

  String get sfdcid => _sfdcid;
  bool get returnCode => _returnCode;
  String get projectInterested => _projectInterested;
  String get name => _name;
  String get mobileNumber => _mobileNumber;
  String get message => _message;
  String get location => _location;
  String get dateofvisit => _dateofvisit;
  String get customerAccountId => _customerAccountId;
  String get configuration => _configuration;
  String get budget => _budget;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sfdcid'] = _sfdcid;
    map['returnCode'] = _returnCode;
    map['ProjectInterested'] = _projectInterested;
    map['Name'] = _name;
    map['MobileNumber'] = _mobileNumber;
    map['message'] = _message;
    map['Location'] = _location;
    map['Dateofvisit'] = _dateofvisit;
    map['CustomerAccountId'] = _customerAccountId;
    map['Configuration'] = _configuration;
    map['Budget'] = _budget;
    return map;
  }

}