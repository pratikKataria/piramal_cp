/// Name : "testBroker23may122"
/// PrimaryContactPerson : "Sudhir khadke"
/// PrimaryMobNo : "7788787878"
/// Email : "devashish2330444nagapure@stetig.in"
/// Pan : "ABCDE6789F"
/// Typeoffirm : "Individual"
/// TnCFlag : true
/// parentCPEventId : "a2yp0000000fguUAAQ"
/// Actual_Paxsize : "1"

class SignupGuestRequest {
  String mobileOTP;
  String emailOTP;


  SignupGuestRequest();

  SignupGuestRequest.fromJson(dynamic json) {
    _name = json['Name'];
    _primaryContactPerson = json['PrimaryContactPerson'];
    _primaryMobNo = json['PrimaryMobNo'];
    _email = json['Email'];
    _pan = json['Pan'];
    _typeoffirm = json['Typeoffirm'];
    _tnCFlag = json['TnCFlag'];
    _parentCPEventId = json['parentCPEventId'];
    _actualPaxsize = json['Actual_Paxsize'];
    _sourcingManager = json['SourcingManager'];
    _location = json['Location'];
  }

  // "SourcingManager": "Test Devashish",
  // "Location": "Zaveri Bazar"

  String _name;
  String _primaryContactPerson;
  String _primaryMobNo;
  String _email;
  String _pan;
  String _typeoffirm;
  bool _tnCFlag;
  String _parentCPEventId;
  String _actualPaxsize;
  String _sourcingManager;
  String _location;

  String get name => _name;
  String get primaryContactPerson => _primaryContactPerson;
  String get primaryMobNo => _primaryMobNo;
  String get email => _email;
  String get pan => _pan;
  String get typeoffirm => _typeoffirm;
  bool get tnCFlag => _tnCFlag;
  String get parentCPEventId => _parentCPEventId;
  String get actualPaxsize => _actualPaxsize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['PrimaryContactPerson'] = _primaryContactPerson;
    map['PrimaryMobNo'] = _primaryMobNo;
    map['Email'] = _email;
    map['Pan'] = _pan;
    map['Typeoffirm'] = _typeoffirm;
    map['TnCFlag'] = _tnCFlag;
    map['parentCPEventId'] = _parentCPEventId;
    map['Actual_Paxsize'] = _actualPaxsize;
    map['SourcingManager'] = _sourcingManager;
    map['Location'] = _location;
    return map;
  }

  set actualPaxsize(String value) {
    _actualPaxsize = value;
  }

  set parentCPEventId(String value) {
    _parentCPEventId = value;
  }

  set tnCFlag(bool value) {
    _tnCFlag = value;
  }

  set typeoffirm(String value) {
    _typeoffirm = value;
  }

  set pan(String value) {
    _pan = value;
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

  String get location => _location;

  set location(String value) {
    _location = value;
  }

  String get sourcingManager => _sourcingManager;

  set sourcingManager(String value) {
    _sourcingManager = value;
  }
}
