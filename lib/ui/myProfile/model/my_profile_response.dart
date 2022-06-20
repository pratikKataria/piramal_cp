/// TypeOfFirm : "Proprietor"
/// SecondaryMobileNo : ""
/// returnCode : true
/// ReraID : "Judi"
/// ReraCertificatePDFUPLOADED : false
/// profilepic : ""
/// PrimaryMobileNo : "5643973934"
/// PrimaryEmail : "grading@gmail.com"
/// PrimaryContactPerson : "fifteen"
/// partnershipDeedsPDFUPLOADED : false
/// PanCardPDFUPLOADED : false
/// PAN : "funk"
/// OthersUPLOADED : true
/// name : "driving"
/// message : "SUCCESS"
/// listOfpartnersPDFUPLOADED : false
/// LISTofDirectorsPDFUPLOADED : false
/// GumsataLicenseUPLOADED : false
/// GSTCertificateUPLOADED : false
/// CertificateOfIncorporationUPLOADED : false
/// BoardResolutionUPLOADED : false
/// AddressProofUPLOADED : true

class MyProfileResponse {
  MyProfileResponse({
    String typeOfFirm,
    String pendingDocument,
    String secondaryMobileNo,
    bool returnCode,
    String reraID,
    bool reraCertificatePDFUPLOADED,
    String profilepic,
    String primaryMobileNo,
    String primaryEmail,
    String primaryContactPerson,
    bool partnershipDeedsPDFUPLOADED,
    bool panCardPDFUPLOADED,
    String pan,
    bool othersUPLOADED,
    String name,
    String message,
    bool listOfpartnersPDFUPLOADED,
    bool lISTofDirectorsPDFUPLOADED,
    bool gumsataLicenseUPLOADED,
    bool gSTCertificateUPLOADED,
    bool certificateOfIncorporationUPLOADED,
    bool boardResolutionUPLOADED,
    bool addressProofUPLOADED,
  }) {
    _typeOfFirm = typeOfFirm;
    _secondaryMobileNo = secondaryMobileNo;
    _returnCode = returnCode;
    _reraID = reraID;
    _reraCertificatePDFUPLOADED = reraCertificatePDFUPLOADED;
    _profilepic = profilepic;
    _primaryMobileNo = primaryMobileNo;
    _primaryEmail = primaryEmail;
    _primaryContactPerson = primaryContactPerson;
    _partnershipDeedsPDFUPLOADED = partnershipDeedsPDFUPLOADED;
    _panCardPDFUPLOADED = panCardPDFUPLOADED;
    _pan = pan;
    _othersUPLOADED = othersUPLOADED;
    _name = name;
    _message = message;
    _listOfpartnersPDFUPLOADED = listOfpartnersPDFUPLOADED;
    _lISTofDirectorsPDFUPLOADED = lISTofDirectorsPDFUPLOADED;
    _gumsataLicenseUPLOADED = gumsataLicenseUPLOADED;
    _gSTCertificateUPLOADED = gSTCertificateUPLOADED;
    _certificateOfIncorporationUPLOADED = certificateOfIncorporationUPLOADED;
    _boardResolutionUPLOADED = boardResolutionUPLOADED;
    _addressProofUPLOADED = addressProofUPLOADED;
    _PendingDocuments = pendingDocument;
  }

  MyProfileResponse.fromJson(dynamic json) {
    _typeOfFirm = json['TypeOfFirm'];
    _secondaryMobileNo = json['SecondaryMobileNo'];
    _returnCode = json['returnCode'];
    _reraID = json['ReraID'];
    _reraCertificatePDFUPLOADED = json['ReraCertificatePDFUPLOADED'];
    _profilepic = json['profilepic'];
    _primaryMobileNo = json['PrimaryMobileNo'];
    _primaryEmail = json['PrimaryEmail'];
    _primaryContactPerson = json['PrimaryContactPerson'];
    _partnershipDeedsPDFUPLOADED = json['partnershipDeedsPDFUPLOADED'];
    _panCardPDFUPLOADED = json['PanCardPDFUPLOADED'];
    _pan = json['PAN'];
    _othersUPLOADED = json['OthersUPLOADED'];
    _name = json['name'];
    _message = json['message'];
    _listOfpartnersPDFUPLOADED = json['listOfpartnersPDFUPLOADED'];
    _lISTofDirectorsPDFUPLOADED = json['LISTofDirectorsPDFUPLOADED'];
    _gumsataLicenseUPLOADED = json['GumsataLicenseUPLOADED'];
    _gSTCertificateUPLOADED = json['GSTCertificateUPLOADED'];
    _certificateOfIncorporationUPLOADED = json['CertificateOfIncorporationUPLOADED'];
    _boardResolutionUPLOADED = json['BoardResolutionUPLOADED'];
    _addressProofUPLOADED = json['AddressProofUPLOADED'];
    _PendingDocuments = json['PendingDocuments'];
  }

  String _typeOfFirm;
  String _secondaryMobileNo;
  bool _returnCode;
  String _reraID;
  bool _reraCertificatePDFUPLOADED;
  String _profilepic;
  String _primaryMobileNo;
  String _primaryEmail;
  String _primaryContactPerson;
  bool _partnershipDeedsPDFUPLOADED;
  bool _panCardPDFUPLOADED;
  String _pan;
  bool _othersUPLOADED;
  String _name;
  String _message;
  bool _listOfpartnersPDFUPLOADED;
  bool _lISTofDirectorsPDFUPLOADED;
  bool _gumsataLicenseUPLOADED;
  bool _gSTCertificateUPLOADED;
  bool _certificateOfIncorporationUPLOADED;
  bool _boardResolutionUPLOADED;
  bool _addressProofUPLOADED;
  String _PendingDocuments;

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

  bool get othersUPLOADED => _othersUPLOADED;

  bool get reraCertificatePDFUPLOADED => _reraCertificatePDFUPLOADED;

  bool get partnershipDeedsPDFUPLOADED => _partnershipDeedsPDFUPLOADED;

  bool get panCardPDFUPLOADED => _panCardPDFUPLOADED;

  bool get listOfpartnersPDFUPLOADED => _listOfpartnersPDFUPLOADED;

  bool get lISTofDirectorsPDFUPLOADED => _lISTofDirectorsPDFUPLOADED;

  bool get gumsataLicenseUPLOADED => _gumsataLicenseUPLOADED;

  bool get gSTCertificateUPLOADED => _gSTCertificateUPLOADED;

  bool get certificateOfIncorporationUPLOADED => _certificateOfIncorporationUPLOADED;

  bool get boardResolutionUPLOADED => _boardResolutionUPLOADED;

  String get PendingDocuments => _PendingDocuments;

  set PendingDocuments(String value) {
    _PendingDocuments = value;
  }

  bool get addressProofUPLOADED => _addressProofUPLOADED;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TypeOfFirm'] = _typeOfFirm;
    map['SecondaryMobileNo'] = _secondaryMobileNo;
    map['returnCode'] = _returnCode;
    map['ReraID'] = _reraID;
    map['ReraCertificatePDFUPLOADED'] = _reraCertificatePDFUPLOADED;
    map['profilepic'] = _profilepic;
    map['PrimaryMobileNo'] = _primaryMobileNo;
    map['PrimaryEmail'] = _primaryEmail;
    map['PrimaryContactPerson'] = _primaryContactPerson;
    map['partnershipDeedsPDFUPLOADED'] = _partnershipDeedsPDFUPLOADED;
    map['PanCardPDFUPLOADED'] = _panCardPDFUPLOADED;
    map['PAN'] = _pan;
    map['OthersUPLOADED'] = _othersUPLOADED;
    map['name'] = _name;
    map['message'] = _message;
    map['listOfpartnersPDFUPLOADED'] = _listOfpartnersPDFUPLOADED;
    map['LISTofDirectorsPDFUPLOADED'] = _lISTofDirectorsPDFUPLOADED;
    map['GumsataLicenseUPLOADED'] = _gumsataLicenseUPLOADED;
    map['GSTCertificateUPLOADED'] = _gSTCertificateUPLOADED;
    map['CertificateOfIncorporationUPLOADED'] = _certificateOfIncorporationUPLOADED;
    map['BoardResolutionUPLOADED'] = _boardResolutionUPLOADED;
    map['AddressProofUPLOADED'] = _addressProofUPLOADED;
    map['PendingDocuments'] = _PendingDocuments;
    return map;
  }
}
