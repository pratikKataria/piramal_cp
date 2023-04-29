/// suburban : ""
/// sfdcid : "a2xp0000000exg2AAA"
/// returnCode : true
/// ProjectInterested : "Piramal Revanta"
/// Name : "Devashish"
/// MobileNumber : "9881560816"
/// message : "Success"
/// Location : "Mumbai"
/// EmailID : ""
/// Dateofvisit : "2022-02-08T00:00:00.000Z"
/// CustomerAccountId : "001p000000y1SqWAAU"
/// Configuration : "1 BHK"
/// Budget : ""

class AllLeadResponse {
 String cpLeadStatus;

  AllLeadResponse({
      String suburban, 
      String sfdcid, 
      bool returnCode, 
      String projectInterested, 
      String name, 
      String mobileNumber, 
      String message, 
      String location, 
      String emailID, 
      String dateofvisit, 
      String customerAccountId, 
      String configuration, 
      String budget,}){
    _suburban = suburban;
    _sfdcid = sfdcid;
    _returnCode = returnCode;
    _projectInterested = projectInterested;
    _name = name;
    _mobileNumber = mobileNumber;
    _message = message;
    _location = location;
    _emailID = emailID;
    _dateofvisit = dateofvisit;
    _customerAccountId = customerAccountId;
    _configuration = configuration;
    _budget = budget;
}

  AllLeadResponse.fromJson(dynamic json) {
    _suburban = json['suburban'];
    _sfdcid = json['sfdcid'];
    _returnCode = json['returnCode'];
    _projectInterested = json['ProjectInterested'];
    _name = json['Name'];
    _mobileNumber = json['MobileNumber'];
    _message = json['message'];
    _location = json['Location'];
    _emailID = json['EmailID'];
    _dateofvisit = json['Dateofvisit'];
    _customerAccountId = json['CustomerAccountId'];
    _configuration = json['Configuration'];
    _budget = json['Budget'];
    cpLeadStatus = json['CP_Lead_Status'];
  }
  String _suburban;
  String _sfdcid;
  bool _returnCode;
  String _projectInterested;
  String _name;
  String _mobileNumber;
  String _message;
  String _location;
  String _emailID;
  String _dateofvisit;
  String _customerAccountId;
  String _configuration;
  String _budget;

  String get suburban => _suburban;
  String get sfdcid => _sfdcid;
  bool get returnCode => _returnCode;
  String get projectInterested => _projectInterested;
  String get name => _name;
  String get mobileNumber => _mobileNumber;
  String get message => _message;
  String get location => _location;
  String get emailID => _emailID;
  String get dateofvisit => _dateofvisit;
  String get customerAccountId => _customerAccountId;
  String get configuration => _configuration;
  String get budget => _budget;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['suburban'] = _suburban;
    map['sfdcid'] = _sfdcid;
    map['returnCode'] = _returnCode;
    map['ProjectInterested'] = _projectInterested;
    map['Name'] = _name;
    map['MobileNumber'] = _mobileNumber;
    map['message'] = _message;
    map['Location'] = _location;
    map['EmailID'] = _emailID;
    map['Dateofvisit'] = _dateofvisit;
    map['CustomerAccountId'] = _customerAccountId;
    map['Configuration'] = _configuration;
    map['Budget'] = _budget;
    map['CP_Lead_Status'] = cpLeadStatus;
    return map;
  }

}