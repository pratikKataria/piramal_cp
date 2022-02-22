/// TypeOfFirm : "Individual"
/// SecondaryMobileNo : "9411111111"
/// returnCode : false
/// ReraID : "123"
/// profilepic : " "
/// PrimaryMobileNo : "9588696494"
/// PrimaryEmail : "test@123.com"
/// PrimaryContactPerson : "9911223344"
/// PAN : "abc123"
/// name : "Test Broker"
/// message : "SUCCESS"
/// PanCardPDFUPLOADED : false
/// listOfpartnersPDFUPLOADED : false
/// LISTofDirectorsPDFUPLOADED : false
/// partnershipDeedsPDFUPLOADED : false
/// ReraCertificatePDFUPLOADED : false

class MyProfileResponse {
  MyProfileResponse({
      String typeOfFirm, 
      String secondaryMobileNo, 
      bool returnCode, 
      String reraID, 
      String profilepic, 
      String primaryMobileNo, 
      String primaryEmail, 
      String primaryContactPerson, 
      String pan, 
      String name, 
      String message, 
      bool panCardPDFUPLOADED, 
      bool listOfpartnersPDFUPLOADED, 
      bool lISTofDirectorsPDFUPLOADED, 
      bool partnershipDeedsPDFUPLOADED, 
      bool reraCertificatePDFUPLOADED,}){
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
    _panCardPDFUPLOADED = panCardPDFUPLOADED;
    _listOfpartnersPDFUPLOADED = listOfpartnersPDFUPLOADED;
    _lISTofDirectorsPDFUPLOADED = lISTofDirectorsPDFUPLOADED;
    _partnershipDeedsPDFUPLOADED = partnershipDeedsPDFUPLOADED;
    _reraCertificatePDFUPLOADED = reraCertificatePDFUPLOADED;
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
    _panCardPDFUPLOADED = json['PanCardPDFUPLOADED'];
    _listOfpartnersPDFUPLOADED = json['listOfpartnersPDFUPLOADED'];
    _lISTofDirectorsPDFUPLOADED = json['LISTofDirectorsPDFUPLOADED'];
    _partnershipDeedsPDFUPLOADED = json['partnershipDeedsPDFUPLOADED'];
    _reraCertificatePDFUPLOADED = json['ReraCertificatePDFUPLOADED'];
  }
  String _typeOfFirm;
  String _secondaryMobileNo;
  bool _returnCode;
  String _reraID;
  String _profilepic;
  String _primaryMobileNo;
  String _primaryEmail;
  String _primaryContactPerson;
  String _pan;
  String _name;
  String _message;
  bool _panCardPDFUPLOADED;
  bool _listOfpartnersPDFUPLOADED;
  bool _lISTofDirectorsPDFUPLOADED;
  bool _partnershipDeedsPDFUPLOADED;
  bool _reraCertificatePDFUPLOADED;

  String get typeOfFirm => _typeOfFirm;
  String get secondaryMobileNo => _secondaryMobileNo;
  bool get returnCode => _returnCode;
  String get reraID => _reraID;
  String get profilepic => _profilepic;
  String get primaryMobileNo => _primaryMobileNo;
  String get primaryEmail => _primaryEmail;
  String get primaryContactPerson => _primaryContactPerson;
  String get pan => _pan;
  String get name => _name;
  String get message => _message;
  bool get panCardPDFUPLOADED => _panCardPDFUPLOADED ?? false;
  bool get listOfpartnersPDFUPLOADED => _listOfpartnersPDFUPLOADED ?? false;
  bool get lISTofDirectorsPDFUPLOADED => _lISTofDirectorsPDFUPLOADED ?? false;
  bool get partnershipDeedsPDFUPLOADED => _partnershipDeedsPDFUPLOADED ?? false;
  bool get reraCertificatePDFUPLOADED => _reraCertificatePDFUPLOADED ?? false;

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
    map['PanCardPDFUPLOADED'] = _panCardPDFUPLOADED;
    map['listOfpartnersPDFUPLOADED'] = _listOfpartnersPDFUPLOADED;
    map['LISTofDirectorsPDFUPLOADED'] = _lISTofDirectorsPDFUPLOADED;
    map['partnershipDeedsPDFUPLOADED'] = _partnershipDeedsPDFUPLOADED;
    map['ReraCertificatePDFUPLOADED'] = _reraCertificatePDFUPLOADED;
    return map;
  }
}