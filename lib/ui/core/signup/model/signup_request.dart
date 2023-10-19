/// Name : "makerchekertest2"
/// PrimaryContactPerson : " priyanshu"
/// PrimaryMobNo : "8754632189"
/// Email : "zT7v@gmail.com"
/// RelationshipManager : "Viral Nandu"
/// Pan : "ABCDE3456J"
/// ReraID : "63456tyui2221"
/// Typeoffirm : "Private Ltd Co."
/// ReraCertificatePDF : " "
/// PanCard : ""
/// LISTofDirectors : ""
/// partnershipDeeds : ""
/// listOfpartners : ""
/// TnCFlag : "true"

class SignupRequest {
  String mobileOTP;
  String emailOTP;
  SignupRequest({
    String name,
    String primaryContactPerson,
    String primaryMobNo,
    String email,
    String relationshipManager,
    String pan,
    String reraID,
    String typeoffirm,
    String reraCertificatePDF,
    String panCard,
    String lISTofDirectors,
    String partnershipDeeds,
    String listOfpartners,
    String tnCFlag,}) {
    _name = name;
    _primaryContactPerson = primaryContactPerson;
    _primaryMobNo = primaryMobNo;
    _email = email;
    _relationshipManager = relationshipManager;
    _pan = pan;
    _reraID = reraID;
    _typeoffirm = typeoffirm;
    _reraCertificatePDF = reraCertificatePDF;
    _panCard = panCard;
    _lISTofDirectors = lISTofDirectors;
    _partnershipDeeds = partnershipDeeds;
    _listOfpartners = listOfpartners;
    _tnCFlag = tnCFlag;
  }

  SignupRequest.fromJson(dynamic json) {
    _name = json['Name'];
    _primaryContactPerson = json['PrimaryContactPerson'];
    _primaryMobNo = json['PrimaryMobNo'];
    _email = json['Email'];
    _relationshipManager = json['RelationshipManager'];
    _pan = json['Pan'];
    _reraID = json['ReraID'];
    _typeoffirm = json['Typeoffirm'];
    _reraCertificatePDF = json['ReraCertificatePDF'];
    _panCard = json['PanCard'];
    _lISTofDirectors = json['LISTofDirectors'];
    _partnershipDeeds = json['partnershipDeeds'];
    _listOfpartners = json['listOfpartners'];
    _tnCFlag = json['TnCFlag'];
  }

  String _name;
  String _primaryContactPerson;
  String _primaryMobNo;
  String _email;
  String _relationshipManager;
  String _pan;
  String _reraID;
  String _typeoffirm;
  String _reraCertificatePDF;
  String _panCard;
  String _lISTofDirectors;
  String _partnershipDeeds;
  String _listOfpartners;
  String _tnCFlag;

  String get name => _name ?? "";

  String get primaryContactPerson => _primaryContactPerson ?? "";

  String get primaryMobNo => _primaryMobNo ?? "";

  String get email => _email ?? "";

  String get relationshipManager => _relationshipManager ?? "";

  String get pan => _pan ?? "";

  String get reraID => _reraID ?? "";

  String get typeoffirm => _typeoffirm ?? "";

  String get reraCertificatePDF => _reraCertificatePDF ?? "";

  String get panCard => _panCard ?? "";

  String get lISTofDirectors => _lISTofDirectors ?? "";

  String get partnershipDeeds => _partnershipDeeds ?? "";

  String get listOfpartners => _listOfpartners ?? "";

  String get tnCFlag => _tnCFlag ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['PrimaryContactPerson'] = _primaryContactPerson;
    map['PrimaryMobNo'] = _primaryMobNo;
    map['Email'] = _email;
    map['RelationshipManager'] = _relationshipManager;
    map['Pan'] = _pan;
    map['ReraID'] = _reraID;
    map['Typeoffirm'] = _typeoffirm;
    map['TnCFlag'] = true;
    return map;
  }

  set tnCFlag(String value) {
    _tnCFlag = value;
  }

  set listOfpartners(String value) {
    _listOfpartners = value;
  }

  set partnershipDeeds(String value) {
    _partnershipDeeds = value;
  }

  set lISTofDirectors(String value) {
    _lISTofDirectors = value;
  }

  set panCard(String value) {
    _panCard = value;
  }

  set reraCertificatePDF(String value) {
    _reraCertificatePDF = value;
  }

  set typeoffirm(String value) {
    _typeoffirm = value;
  }

  set reraID(String value) {
    _reraID = value;
  }

  set pan(String value) {
    _pan = value;
  }

  set relationshipManager(String value) {
    _relationshipManager = value;
  }

  set email(String value) {
    _email = value;
  }

  set primaryMobNo(String value) {
    _primaryMobNo = value;
  }

  set primaryContactPerson(String value) {
    _primaryContactPerson = value;
  }

  set name(String value) {
    _name = value;
  }
}