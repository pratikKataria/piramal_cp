/// TypeOfFirm : "Individual"
/// SecondaryMobileNo : "9411111111"
/// returnCode : 2
/// ReraID : "123"
/// profilepic : null
/// PrimaryMobileNo : "9911223355"
/// PrimaryEmail : "test@123.com"
/// PrimaryContactPerson : "9911223344"
/// PAN : "abc123"
/// name : "Test Broker"
/// message : "SUCCESS"

class MyProfileResponse {
  MyProfileResponse({
      String typeOfFirm, 
      String secondaryMobileNo, 
      int returnCode, 
      String reraID, 
      dynamic profilepic, 
      String primaryMobileNo, 
      String primaryEmail, 
      String primaryContactPerson, 
      String pan, 
      String name, 
      String message,}){
    _typeOfFirm = typeOfFirm;
    _secondaryMobileNo = secondaryMobileNo;
    _returnCode = returnCode;
    _reraID = reraID;
    _profilepic = profilepic;
    _primaryMobileNo = primaryMobileNo;
    _primaryEmail = primaryEmail;
    _primaryContactPerson = primaryContactPerson;
    _pan = pan;
    _name = name;
    _message = message;
}

  MyProfileResponse.fromJson(dynamic json) {
    _typeOfFirm = json['TypeOfFirm'];
    _secondaryMobileNo = json['SecondaryMobileNo'];
    _returnCode = json['returnCode'];
    _reraID = json['ReraID'];
    _profilepic = json['profilepic'];
    _primaryMobileNo = json['PrimaryMobileNo'];
    _primaryEmail = json['PrimaryEmail'];
    _primaryContactPerson = json['PrimaryContactPerson'];
    _pan = json['PAN'];
    _name = json['name'];
    _message = json['message'];
  }
  String _typeOfFirm;
  String _secondaryMobileNo;
  int _returnCode;
  String _reraID;
  dynamic _profilepic;
  String _primaryMobileNo;
  String _primaryEmail;
  String _primaryContactPerson;
  String _pan;
  String _name;
  String _message;

  String get typeOfFirm => _typeOfFirm;
  String get secondaryMobileNo => _secondaryMobileNo;
  int get returnCode => _returnCode;
  String get reraID => _reraID;
  dynamic get profilepic => _profilepic;
  String get primaryMobileNo => _primaryMobileNo;
  String get primaryEmail => _primaryEmail;
  String get primaryContactPerson => _primaryContactPerson;
  String get pan => _pan;
  String get name => _name;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TypeOfFirm'] = _typeOfFirm;
    map['SecondaryMobileNo'] = _secondaryMobileNo;
    map['returnCode'] = _returnCode;
    map['ReraID'] = _reraID;
    map['profilepic'] = _profilepic;
    map['PrimaryMobileNo'] = _primaryMobileNo;
    map['PrimaryEmail'] = _primaryEmail;
    map['PrimaryContactPerson'] = _primaryContactPerson;
    map['PAN'] = _pan;
    map['name'] = _name;
    map['message'] = _message;
    return map;
  }

}